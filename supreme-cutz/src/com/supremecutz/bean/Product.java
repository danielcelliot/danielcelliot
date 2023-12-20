package com.supremecutz.bean;

public class Product {

	private int productId;
	private String name;
	private String brand;
	private String desc;
	private float weight;
	private double unitPrice;
	private byte[] imageSmall;
	private int qty;
	private double subtotal;
	
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	public float getWeight() {
		return weight;
	}
	public void setWeight(float weight) {
		this.weight = weight;
	}
	
	public double getPrice() {
		return unitPrice;
	}
	public void setPrice(double price) {
		this.unitPrice = price;
	}
	
	public byte[] getImageSmall() {
		return imageSmall;
	}
	public void setImageSmall(byte[] imageSmall) {
		this.imageSmall = imageSmall;
	}
	
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public double getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(double subtotal) {
		this.subtotal = subtotal;
	}
}
