package com.kgc.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Clothes {
    private Integer id;

    private String typename;

    private String discription;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date ontime;

    private Double price;

    private String picpath;

    public Clothes(Integer id, String typename, String discription, Date ontime, Double price, String picpath) {
        this.id = id;
        this.typename = typename;
        this.discription = discription;
        this.ontime = ontime;
        this.price = price;
        this.picpath = picpath;
    }

    public Clothes() {
        super();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTypename() {
        return typename;
    }

    public void setTypename(String typename) {
        this.typename = typename == null ? null : typename.trim();
    }

    public String getDiscription() {
        return discription;
    }

    public void setDiscription(String discription) {
        this.discription = discription == null ? null : discription.trim();
    }

    public Date getOntime() {
        return ontime;
    }

    public void setOntime(Date ontime) {
        this.ontime = ontime;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getPicpath() {
        return picpath;
    }

    public void setPicpath(String picpath) {
        this.picpath = picpath == null ? null : picpath.trim();
    }
}