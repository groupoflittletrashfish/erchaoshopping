package controller;


import entity.Order;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.OrderService;

import javax.annotation.Resource;

@Controller
@RequestMapping("order")
public class OrderController {

    @Resource(name="orderServiceImpl")
    private OrderService orderService;

    @RequestMapping("toOrderList")
    public String toOrderList(){
        return "ordertable";
    }

    @RequestMapping("orderList")
    @ResponseBody
    public JSONObject orderList(@RequestParam(value="limit",required = false) Integer limit,@RequestParam(value="offset",required = false) Integer offset,@RequestParam(value="query",required = false)String query
            ,@RequestParam(value="type",required = false) String type){
        System.out.println("----:"+type);
        return orderService.orderList(limit,offset,query,type);
    }


    @RequestMapping("toUpdateOrder")
    public String toUpdateOrder(){
        return "updateorder";
    }

    @RequestMapping("updateOrder")
    @ResponseBody
    public String  updateOrder(Order order){
        System.out.println("id:"+order);
        return "true";
    }
}
