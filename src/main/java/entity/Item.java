package entity;

import java.io.Serializable;
import java.sql.Timestamp;

public class Item implements Serializable{
    private Long id;
    private Float price;
    private Long taobaoId;
    private String title;
    private String propertiesNames;
    private Timestamp created;
    private Timestamp modified;
    private Long repertory;

    public Long getRepertory() {
        return repertory;
    }

    public void setRepertory(Long repertory) {
        this.repertory = repertory;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public Long getTaobaoId() {
        return taobaoId;
    }

    public void setTaobaoId(Long taobaoId) {
        this.taobaoId = taobaoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPropertiesNames() {
        return propertiesNames;
    }

    public void setPropertiesNames(String propertiesNames) {
        this.propertiesNames = propertiesNames;
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
        return "Item{" +
                "id=" + id +
                ", price=" + price +
                ", taobaoId=" + taobaoId +
                ", title='" + title + '\'' +
                ", propertiesNames='" + propertiesNames + '\'' +
                ", created=" + created +
                ", modified=" + modified +
                '}';
    }
}
