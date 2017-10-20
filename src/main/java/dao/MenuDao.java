package dao;

import entity.Menu;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MenuDao {
    public List<Menu> mainMenus(long parentMenu);
}
