package dao;

import entity.Item;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("itemDao")
public interface ItemDao {
    public List<Item> allItems();
}
