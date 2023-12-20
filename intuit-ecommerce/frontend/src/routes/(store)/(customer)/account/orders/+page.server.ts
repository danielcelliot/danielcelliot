import type { Order } from '$lib/types/medusa.js';
import { error, redirect } from '@sveltejs/kit';

// const cancelOrderSchema = z.object({
// 	order_id: z.string()
// });

// const cancel: Action = async ({ request, fetch }) => {
// 	const form = await superValidate(request, cancelOrderSchema);
// 	if (!form.valid) return fail(400, { form });

// 	const errorMsg = {
// 		type: 'error',
// 		text: 'Unable to cancel order'
// 	} as const;
// 	const successMsg = {
// 		type: 'success',
// 		text: 'Your order has been cancelled'
// 	} as const;

// 	return (await cancelOrder(form.data.order_id, fetch))
// 		? message(form, successMsg)
// 		: message(form, errorMsg, { status: 400 });
// };

// export const actions: Actions = { cancel };

export async function load({ fetch }) {
	const fetchCustomerOrders = async () => {
		const response = await fetch('/api/store/customers/me/orders');

		if (response.ok) return (await response.json()) as Order[];

		if (response.status === 401)
			throw redirect(303, '/accounts/customer/signin?redirect_to=/account/orders');
		else if (response.status === 500) throw error(500, { message: 'Internal error' });

		throw error(400, 'Invalid Request');
	};

	return {
		orders: fetchCustomerOrders()
	};
}
