package controller;

import org.apache.cxf.endpoint.Client;
import org.apache.cxf.jaxws.endpoint.dynamic.JaxWsDynamicClientFactory;

import javax.xml.namespace.QName;

public class Test {
    public static void main(String[] args) throws Exception {
//        try {
//            JaxWsDynamicClientFactory clientFactory = JaxWsDynamicClientFactory.newInstance();
//            Client client = clientFactory.createClient("http://qamallpos.mapletree.com.sg:9001/frdif/n_frdif.asmx?WSDL");
//            Object[] result = client.invoke("processdata", "test","00B54E5ADD61AC9C","2000","3525,3525/800001/830426,0000,A_FCHECK,A2_FDATE C_FTIMEOPEN,1,00001051,C_FCKTOT,1,C_FCKTOT,,,,C_FCKTOT,0,0,0,0,0,0,0,,","",0,"");
//            System.out.println(result[0]);
//        } catch (Exception e) {
//            System.err.println(e.toString());
//        }

//        JaxWsDynamicClientFactory dcf=JaxWsDynamicClientFactory.newInstance();
//        Client client=dcf.createClient("http://qamallpos.mapletree.com.sg:9001/frdif/n_frdif.asmx?wsdl");
//        QName name=new QName("http://tempurl.org","processdata");
//        Object[] obj=client.invoke(name,"test","00B54E5ADD61AC9C","2000","3525,3525/800001/830426,0000,A_FCHECK,A2_FDATE C_FTIMEOPEN,1,00001051,C_FCKTOT,1,C_FCKTOT,,,,C_FCKTOT,0,0,0,0,0,0,0,,","",0,"");
            String a="aaasssssvvvvvvvbbb";
            a=a.replace("ssss","66666");
        System.out.println(a);
    }
}
