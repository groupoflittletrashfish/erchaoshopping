package controller;

import entity.Menu;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.MenuService;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("menus")
public class MenuController {


    @Resource(name="menuServiceImpl")
    private MenuService menuService;

    @RequestMapping("mainList")
    @ResponseBody
    public List<Menu> mainList(){
        return menuService.mainList();
    }
}
