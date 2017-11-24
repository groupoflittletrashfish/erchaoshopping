package controller;

import entity.Item;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.ItemService;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("items")
public class ItemsController {

    @Resource(name="itemService")
    private ItemService itemService;

    @RequestMapping("allItems")
    @ResponseBody
    public List<Item> allItems(){
        return itemService.allItems();
    }


    @RequestMapping("toRepertory")
    public String toRepertory(){
        return "repertory";
    }
}
