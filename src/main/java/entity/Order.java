package entity;

import java.io.Serializable;
import java.sql.Timestamp;

public class Order implements Serializable{
    private Long id;
    private Long tid;
    private Long taobaoId;
    private Long numIid;
    private Integer num;
    private Float price;
    private String title;
    private String status;
    private Timestamp created;
    private Timestamp modified;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getTid() {
        return tid;
    }

    public void setTid(Long tid) {
        this.tid = tid;
    }

    public Long getTaobaoId() {
        return taobaoId;
    }

    public void setTaobaoId(Long taobaoId) {
        this.taobaoId = taobaoId;
    }

    public Long getNumIid() {
        return numIid;
    }

    public void setNumIid(Long numIid) {
        this.numIid = numIid;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
                ", num=" + num +
                ", price=" + price +
                ", title='" + title + '\'' +
                ", status='" + status + '\'' +
                ", created=" + created +
                ", modified=" + modified +
                '}';
    }
}
