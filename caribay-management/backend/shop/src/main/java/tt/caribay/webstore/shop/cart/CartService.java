package tt.caribay.webstore.shop.cart;

import java.util.Arrays;

import javax.enterprise.context.ApplicationScoped;
import javax.ws.rs.BadRequestException;
import javax.ws.rs.core.Response;

import io.smallrye.mutiny.Uni;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import tt.caribay.webstore.common.exception.ErrorResponse;
import tt.caribay.webstore.common.exception.ErrorResponse.ErrorMessage;
import tt.caribay.webstore.shop.product.ProductRepository;

@ApplicationScoped
@RequiredArgsConstructor
@Slf4j
public class CartService {
    
    private final CartRepository cartRepository;
    private final ProductRepository productRepository;

    public Uni<Integer> addItemToCart(Integer id, CartDto cartDto) {
        
        // TODO: Remove check once customer session is implemented
        Uni<Boolean> cartExists = cartRepository
                .doesCartExist(id)
                .onItem().invoke(r -> log.debug("Does cart exist: {}", r));

        // Uni<Boolean> hasStock = productRepository
        //         .doesMerchantHaveStock(
        //             cartDto.getProductId(),
        //             cartDto.getMerchantId()
        //         )
        //         .onItem().invoke(r -> log.debug("Does seller have stock: {}", r));

        Uni<Boolean> hasStock = cartExists
                .onItem().transformToUni(bool -> bool
                    ? productRepository.doesMerchantHaveStock(
                        cartDto.getProductId(),
                        cartDto.getMerchantId()
                    )
                    : Uni.createFrom().nullItem()
                )
                .onItem().ifNull().failWith(new BadRequestException(
                    Response.status(Response.Status.BAD_REQUEST)
                            .entity(
                                new ErrorResponse(
                                    new ErrorMessage(
                                        "cartId",
                                        "There is no customer associated with this cart ID"
                                    )
                                )
                            )
                            .build()
                ))
                .onItem().invoke(r -> log.debug("Does seller have stock: {}", r));

        Uni<Boolean> isItemInCart = hasStock
                .onItem().transformToUni(bool -> bool
                    ? cartRepository.isItemInCart(
                        id,
                        cartDto.getProductId(),
                        cartDto.getMerchantId()
                    )
                    : Uni.createFrom().nullItem()
                )
                .onItem().ifNull().failWith(new BadRequestException(
                    Response.status(Response.Status.BAD_REQUEST)
                            .entity(
                                new ErrorResponse(
                                    new ErrorMessage(
                                        Arrays.toString(new String[] {"merchantId", "productId"}),
                                        "This product is not available from seller"
                                    )
                                )
                            )
                            .build()
                ))
                .onItem().invoke(r -> log.debug("Is product already in cart: {}", r));

        // TODO: Check that DTO quantity is not above order limit

        Uni<Integer> itemAddedResult = isItemInCart
                .onItem().transformToUni(bool -> bool
                    ? cartRepository.updateItemInCart(
                        id,
                        cartDto.getProductId(),
                        cartDto.getMerchantId(),
                        cartDto.getQuantity(),
                        false)
                    : cartRepository.addItemToCart(
                        id,
                        cartDto.getProductId(),
                        cartDto.getMerchantId(),
                        cartDto.getQuantity()
                    )
                )
                .onItem().invoke(r -> log.debug("Item added: {}", cartDto));

        return itemAddedResult;
    }
}
