package controller;


import entity.Item;
import entity.Order;
import entity.Trade;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import service.OrderService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("order")
public class OrderController {

    @Resource(name = "orderServiceImpl")
    private OrderService orderService;

    @RequestMapping("toOrderList")
    public String toOrderList() {
        return "ordertable";
    }

    @RequestMapping("orderList")
    @ResponseBody
    public JSONArray orderList(@RequestParam(value = "query", required = false) String query) {
        if (query == null) {
            query = "";
        }
        return orderService.orderList(query);
    }


    @RequestMapping("toCreateOrder")
    public String toUpdateOrder() {
        return "createorder";
    }

    @RequestMapping("updateOrder")
    public String updateOrder(@RequestParam("tid") Long tid, ModelMap map) {
        map.put("trade",orderService.selectTradeById(tid));
        return "updateorder";
    }

    @RequestMapping("allItems")
    @ResponseBody
    public List<Item> allItems() {
        return orderService.allItems();
    }

    @RequestMapping("insertData")
    @ResponseBody
    public boolean insertData(Trade trade, @RequestParam("data") String data) {
        return  orderService.insertData(trade, data);
    }


    @RequestMapping("batchDelete")
    @ResponseBody
    public boolean batchDelete(@RequestParam("tids") String tids){
        System.out.println("tid:"+tids);
        return orderService.batchDelete(tids);
    }

    @RequestMapping("tradeOrders")
    @ResponseBody
    public List<Order> tradeOrders(@RequestParam("id") Long id){
        return orderService.tradeOrders(id);
    }

    @RequestMapping("submitUpdate")
    @ResponseBody
    public boolean submitUpdate(Trade trade,@RequestParam(value = "param",required = false) String param){
        System.out.println("trade:"+trade);
        boolean res1=orderService.updateTrade(trade);
        boolean res2=orderService.updateOrder(trade.getTid(),param);
        if(res1&&res2){
            return true;
        }
        return false;
    }


    @RequestMapping("aaa")
    public void aaa(HttpServletRequest request){
        try {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(4096*1000); // 设置缓冲区大小，这里是4kb
            factory.setRepository(new File("D:\\ideaSpace\\erchao\\target\\liyihan\\upload\\temp"));// 设置缓冲区目录
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setSizeMax(4194304); // 设置最大文件尺寸，这里是4MB
            List<FileItem> items = upload.parseRequest(request);// 得到所有的文件
            System.out.println("size:"+items .size());
            Iterator<FileItem> i = items.iterator();
            while (i.hasNext()) {
                FileItem fi = (FileItem) i.next();
                String fileName = fi.getName();
                System.out.println(fileName);
                if (fileName != null) {
                    File fullFile = new File(fi.getName());
                    File savedFile = new File("D:\\ideaSpace\\erchao\\target\\liyihan\\upload\\temp", fullFile.getName());
                    fi.write(savedFile);
                }
            }
        } catch (Exception e) {
            // 可以跳转出错页面
            e.printStackTrace();
        }

    }


}
