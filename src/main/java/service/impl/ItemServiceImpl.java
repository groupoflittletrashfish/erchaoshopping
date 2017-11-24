package service.impl;

import dao.ItemDao;
import entity.Item;
import org.springframework.stereotype.Service;
import service.ItemService;

import javax.annotation.Resource;
import java.util.List;

@Service("itemService")
public class ItemServiceImpl implements ItemService{
    @Resource(name="itemDao")
    private ItemDao itemDao;

    public List<Item> allItems() {
        return itemDao.allItems();
    }
}
