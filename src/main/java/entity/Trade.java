package entity;

import java.io.Serializable;
import java.sql.Timestamp;

public class Trade implements Serializable {
    private long id;
    private long tabobaoId;
    private long tid;
    private String buyerNick;
    private float payment;
    private String status;
    private String receiverAddress;
    private String receiverMobile;
    private Timestamp created;
    private Timestamp modified;
    private String receiverName;
    private String sellerMemo;
    private float discountFee;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getTabobaoId() {
        return tabobaoId;
    }

    public void setTabobaoId(long tabobaoId) {
        this.tabobaoId = tabobaoId;
    }

    public long getTid() {
        return tid;
    }

    public void setTid(long tid) {
        this.tid = tid;
    }

    public String getBuyerNick() {
        return buyerNick;
    }

    public void setBuyerNick(String buyerNick) {
        this.buyerNick = buyerNick;
    }

    public float getPayment() {
        return payment;
    }

    public void setPayment(float payment) {
        this.payment = payment;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getReceiverMobile() {
        return receiverMobile;
    }

    public void setReceiverMobile(String receiverMobile) {
        this.receiverMobile = receiverMobile;
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

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getSellerMemo() {
        return sellerMemo;
    }

    public void setSellerMemo(String sellerMemo) {
        this.sellerMemo = sellerMemo;
    }

    public float getDiscountFee() {
        return discountFee;
    }

    public void setDiscountFee(float discountFee) {
        this.discountFee = discountFee;
    }

    @Override
    public String toString() {
        return "Trade{" +
                "id=" + id +
                ", tabobaoId=" + tabobaoId +
                ", tid=" + tid +
                ", buyerNick='" + buyerNick + '\'' +
                ", payment=" + payment +
                ", status='" + status + '\'' +
                ", receiverAddress='" + receiverAddress + '\'' +
                ", receiverMobile='" + receiverMobile + '\'' +
                ", created=" + created +
                ", modified=" + modified +
                ", receiverName='" + receiverName + '\'' +
                ", sellerMemo='" + sellerMemo + '\'' +
                ", discountFee=" + discountFee +
                '}';
    }
}
