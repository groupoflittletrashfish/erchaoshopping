package entity;

import java.io.Serializable;
import java.sql.Timestamp;

public class Menu implements Serializable{
    private long id;
    private String menuName;
    private long parentMenu;
    private String url;
    private Timestamp createTime;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public long getParentMenu() {
        return parentMenu;
    }

    public void setParentMenu(long parentMenu) {
        this.parentMenu = parentMenu;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "Menu{" +
                "id=" + id +
                ", menuName='" + menuName + '\'' +
                ", parentMenu=" + parentMenu +
                ", url='" + url + '\'' +
                ", createTime=" + createTime +
                '}';
    }
}
