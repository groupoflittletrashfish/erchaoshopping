package service.impl;

import dao.MenuDao;
import entity.Menu;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;
import service.MenuService;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MenuServiceImpl implements MenuService{

    @Resource(name="menuDao")
    private MenuDao menuDao;

    public List<Menu> mainList() {
        List<Menu> menuList= menuDao.mainMenus(0);
        JSONArray array=new JSONArray();
        for(Menu m:menuList){
            JSONObject obj=new JSONObject();
            obj.put("mainMenu",m);
            List<Menu> sonMenu=menuDao.mainMenus(m.getId());
            if(!sonMenu.isEmpty()&&sonMenu!=null){
                obj.put("sonMenu",sonMenu);
            }
            array.add(obj);
        }
        return array;
    }
}
