package entity;

import java.io.Serializable;
import java.sql.Timestamp;

public class Order implements Serializable{
    private long id;
    private long tid;
    private long taobaoId;
    private long numIid;
    private long skuId;
    private long num;
    private String title;
    private String picPath;
    private String refundStatus;
    private String status;
    private float price;
    private String orderFrom;
    private float totalFree;
    private float adjustFee;
    private String skuPropertiesName;
    private Timestamp consignTime;
    private String shippingType;
    private Timestamp created;
    private Timestamp modified;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getTid() {
        return tid;
    }

    public void setTid(long tid) {
        this.tid = tid;
    }

    public long getTaobaoId() {
        return taobaoId;
    }

    public void setTaobaoId(long taobaoId) {
        this.taobaoId = taobaoId;
    }

    public long getNumIid() {
        return numIid;
    }

    public void setNumIid(long numIid) {
        this.numIid = numIid;
    }

    public long getSkuId() {
        return skuId;
    }

    public void setSkuId(long skuId) {
        this.skuId = skuId;
    }

    public long getNum() {
        return num;
    }

    public void setNum(long num) {
        this.num = num;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPicPath() {
        return picPath;
    }

    public void setPicPath(String picPath) {
        this.picPath = picPath;
    }

    public String getRefundStatus() {
        return refundStatus;
    }

    public void setRefundStatus(String refundStatus) {
        this.refundStatus = refundStatus;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getOrderFrom() {
        return orderFrom;
    }

    public void setOrderFrom(String orderFrom) {
        this.orderFrom = orderFrom;
    }

    public float getTotalFree() {
        return totalFree;
    }

    public void setTotalFree(float totalFree) {
        this.totalFree = totalFree;
    }

    public float getAdjustFee() {
        return adjustFee;
    }

    public void setAdjustFee(float adjustFee) {
        this.adjustFee = adjustFee;
    }

    public String getSkuPropertiesName() {
        return skuPropertiesName;
    }

    public void setSkuPropertiesName(String skuPropertiesName) {
        this.skuPropertiesName = skuPropertiesName;
    }

    public Timestamp getConsignTime() {
        return consignTime;
    }

    public void setConsignTime(Timestamp consignTime) {
        this.consignTime = consignTime;
    }

    public String getShippingType() {
        return shippingType;
    }

    public void setShippingType(String shippingType) {
        this.shippingType = shippingType;
    }

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    public Timestamp getModified() {
        return modified;
    }

    public void setModified(Timestamp modified) {
        this.modified = modified;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", tid=" + tid +
                ", taobaoId=" + taobaoId +
                ", numIid=" + numIid +
                ", skuId=" + skuId +
                ", num=" + num +
                ", title='" + title + '\'' +
                ", picPath='" + picPath + '\'' +
                ", refundStatus='" + refundStatus + '\'' +
                ", status='" + status + '\'' +
                ", price=" + price +
                ", orderFrom='" + orderFrom + '\'' +
                ", totalFree=" + totalFree +
                ", adjustFee=" + adjustFee +
                ", skuPropertiesName='" + skuPropertiesName + '\'' +
                ", consignTime=" + consignTime +
                ", shippingType='" + shippingType + '\'' +
                ", created=" + created +
                ", modified=" + modified +
                '}';
    }
}
