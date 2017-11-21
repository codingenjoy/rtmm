package com.auchan.rtmm.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

//import com.auchan.rtmm.supplier.vo.ComLicenceVO;

/**
 * json工具类. 使用 jackson 的 json 处理库
 * 
 * @author suyulin
 */
public class JsonUtil {

    private static ObjectMapper mapper = new ObjectMapper(); // can reuse, share globally

    /**
     * 把 java 对象转化为 json 对象
     */
    public static <T> String java2json(T t) {
        String json = null;
        try {
            json = mapper.writeValueAsString(t); // 把 java 对象转化为 json 对象
        } catch (JsonGenerationException ex) {
            Logger.getLogger(JsonUtil.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JsonMappingException ex) {
            Logger.getLogger(JsonUtil.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(JsonUtil.class.getName()).log(Level.SEVERE, null, ex);
        }

        return json;
    }
    
    /**
     * 先把 java 对象转化为 json 对象, 然后编码返回。
     * 
     * 例如, 编码成: pmrggyloinqw4y3fnqrduztbnrzwk7i
     * 
     * 用途：
     * 在  front 或者 backend 里面的复杂表单查询，把 N 个查询条件封装到一个 dto 里面，
     * 通过调用本方法，把整个 dto 对象 转成 一个 “由小写字母和数字组成的”字符串，然后，把这个字符串作为一个参数传递给  web-core 的某个 URL 来处理。
     * 
     * 好处：简单，方便，彻底避免乱码
     */
    public static <T> String java2json_last_encode(T t) {
        String json = java2json(t); // {"canCancel":false}
        return Codec.encode(json); // pmrggyloinqw4y3fnqrduztbnrzwk7i
    }
    
    /**
     * 先把 "字符串"(例如: pmrggyloinqw4y3fnqrduztbnrzwk7i)  解码为 json 串，然后把 json 串转化为 java 对象
     * 
     * 用途：
     * web-core 接收到一个 http 请求，里面有一个参数，是一个 "字符串"(例如: pmrggyloinqw4y3fnqrduztbnrzwk7i)，
     * 通过调用本方法，直接把这个"字符串" 转成 dto 查询条件对象
     */
    public static <T> T json2java_first_decode(String json, Class<T> valueType) {
    	json = Codec.decode(json);
    	return json2java(json, valueType);
    }
    
    /**
     * 把 json 对象转化为 java 对象
     *
     * -----------------------------------------------------------------------
     * 说明(1):
     * 1. json 对象中的属性 在 java 对象中 必须存在, 否则会报错;
     * 2. java 对象中 可以 包含 json 对象中 没有的属性.
     *
     * 以上两点, 可以总结如下: json 对象中的属性列表 必须是 java 对象中的属性列表 的一个子集 (子集的特例是: 自己是自己的子集)
     * 
     * 用途: 把简单的 json 对象 转成 简单的 JavaBean 对象, 例如: Apple apple = JsonUtil.json2java(json, Apple.class);
     * -----------------------------------------------------------------------
     * 
     * 说明(2):
     * 如果 json 对象比较复杂, 可以先转成 Map 对象, 再操作 Map 对象.
     * 这种方式不太 OO, 但可以说是 "万能的" 转换方法
     * 
     * 用途: 把复杂的 json 对象 转成 Map 对象, 例如: Map<String, Object> map = JsonUtil.json2java(json, Map.class);
     * -----------------------------------------------------------------------
     *
     * 说明(3):
     * 如果 json 对象比较复杂, 也可以 转成 复杂的 JavaBean 对象.
     * 这种方式比较 OO, 但要求写一个复杂的 JavaBean 对象, 来与 json 对象 匹配
     *
     * 用途: 把复杂的 json 对象 转成 复杂的 JavaBean 对象, 例如: JsonExampleVo vo = JsonUtil.json2java(json, JsonExampleVo.class);
     *
     * 具体用法: 见 main() 方法, 以及 JsonExampleVo 类
     */
    public static <T> T json2java(String json, Class<T> valueType) {
        T obj = null;
        try {
            obj = mapper.readValue(json, valueType); // 把 json 对象转化为 java 对象
            //User user = mapper.readValue(json, User.class); // 把 json 对象转化为 java 对象
        } catch (JsonGenerationException ex) {
            Logger.getLogger(JsonUtil.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JsonMappingException ex) {
            Logger.getLogger(JsonUtil.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(JsonUtil.class.getName()).log(Level.SEVERE, null, ex);
        }

        return obj;
    }

    /**
     * 打印map
     */
    private static void printMap(Map map) {
        if (SpringUtil.isEmpty(map)) {
            return;
        }

        Set<String> keySet = map.keySet();
        for(String key: keySet) {
            System.out.println("key = " + key);
            Object obj = map.get(key);

            String className = obj.getClass().getName();
            System.out.println("type =" + className);

            boolean isMap = className.toLowerCase().indexOf("map") >= 0;
            boolean isList = className.toLowerCase().indexOf("list") >= 0;

            if(isMap) {
                System.out.println("==== is map ====");
                printMap((Map) obj); //递归调用
            }
            else if(isList) {
                List list = (List) obj;
                System.out.println("==== is list ==== , size = " + list.size());
                for(Object oo: list) {
                    System.out.println("element type =" + oo.getClass().getName());
                    System.out.println("element toString =" + oo.toString());
                }
            }
            else {
                System.out.println("obj.toString = " + obj.toString());
            }
        }
    }

    /**
     * 
     * json格式转换为list格式
     * 支持多种json格式
     * 1.格式为 {'key','123','value':'ashdasd'},{...}
     * 2.格式为 {"key","123","value":"ashdasd"},{...}
     * 
     * 其他说明
     * 1. json 对象中的属性 在 java 对象中 必须存在, 否则会报错;
     * 2. java 对象中 可以 包含 json 对象中 没有的属性.
     * 
     * 
     */
    public static <T>List<T> json2javaList(String json,Class<T> valueType) {
    	List<T>  jsonArray =new ArrayList<T>();
    	String sss= json.replace("[", "").replace("]", "").replace("\'", "\"");            
    	String[] list = sss.split("\\},\\{");  			
		for (int i = 0; i < list.length; i++) {
			//处理分割后的字符串
			if(!list[i].startsWith("{")){
				list[i]="{"+list[i];
			}
			if(!list[i].endsWith("}")){				
				list[i]=list[i]+"}";				
			}		
			//处理
			T obj=(T) JsonUtil.json2java(list[i], valueType);
			jsonArray.add(obj);
			
		}
    	
    	return jsonArray;
    }
    
    
    /**
     * test: 上面两个 "转换" 方法,
     * 主要是 test: 把复杂的 json 对象转化为 java 对象
     *
     * 这里, json 对象的格式是:
-------------------------------------------------------------------------
     {
	"code":200,
	"message":"Request processing succeeded",
	"header":{},
	"result":{
		"totalCount":66,
		"pageNum":1,
		"pageSize":2,
		"bookList":[
		  {"name":"Spring MVC 3.0","author":"Rod Johnson","page":180,"price":34.99},
		  {"name":"Hibernate In Action","author":"Gavin King","page":260,"price":50.78}
		],
		"otherList":[],
		"bookCountList":[
		  {"categoryId":1,"bookCount":11,"categoryName":"Java"},
		  {"categoryId":2,"bookCount":22,"categoryName":"PHP"},
		  {"categoryId":3,"bookCount":33,"categoryName":"Python"}
		]
	}
     }
-------------------------------------------------------------------------
     *
     * 注意1: "header":{}, header 里面通常为: 空的 json 对象, 不确定 json 对象 的格式
     * 注意2: "otherList":[], otherList 里面通常为: 空的 json 数组, 不确定 json 对象 的格式
     * @throws Exception 
     */
    public static void main(String[] args) throws Exception {
    	
    /*	//josn格式转化为list
    	
    	//1.格式1
    	String comLicencesList="[{'licnceType':8,'licnceNo':'asd1235asd','issueBy':'123asd123sdas','validStartDate':'2014-11-04','validEndDate':'2014-11-29'},"
    			+ "{'licnceType':12,'licnceNo':'asd1235asd','issueBy':'123asd123sdas','validStartDate':'2014-11-04','validEndDate':'2014-11-29'}"
    			+ "]";    	
    	//2.格式2
    	String comls="{\"licnceType\":8,\"licnceNo\":\"asd1235asd\",\"issueBy\":\"123asd123sdas\",\"validStartDate\":\"2014-11-04\",\"validEndDate\":\"2014-11-29\"}"
       +"{\"licnceType\":12,\"licnceNo\":\"asd1235asd\",\"issueBy\":\"123asd123sdas\",\"validStartDate\":\"2014-11-04\",\"validEndDate\":\"2014-11-29\"}";    	
    	List<ComLicenceVO> cls=JsonUtil.json2javaList(comls, ComLicenceVO.class);  	 
    	for (ComLicenceVO comLicenceVO : cls) {
			System.out.println(comLicenceVO.getLicnceType());
		}
    	*/

    	/*
        String json = "{\"code\":200,\"message\":\"Request processing succeeded\",\"header\":{},\"result\":{\"totalCount\":66,\"pageNum\":1,\"pageSize\":2,\"bookList\":[{\"name\":\"Spring MVC 3.0\",\"author\":\"Rod Johnson\",\"page\":180,\"price\":34.99},{\"name\":\"Hibernate In Action\",\"author\":\"Gavin King\",\"page\":260,\"price\":50.78}],\"otherList\":[],\"bookCountList\":[{\"categoryId\":1,\"bookCount\":11,\"categoryName\":\"Java\"},{\"categoryId\":2,\"bookCount\":22,\"categoryName\":\"PHP\"},{\"categoryId\":3,\"bookCount\":33,\"categoryName\":\"Python\"}]}}";
        //String json = "{\"code\":200,\"message\":\"Request processing succeeded\",\"header\":{\"name\":\"Spring MVC 3.0\",\"author\":\"Rod Johnson\",\"page\":180,\"price\":34.99},\"result\":{\"totalCount\":66,\"pageNum\":1,\"pageSize\":2,\"bookList\":[{\"name\":\"Spring MVC 3.0\",\"author\":\"Rod Johnson\",\"page\":180,\"price\":34.99},{\"name\":\"Hibernate In Action\",\"author\":\"Gavin King\",\"page\":260,\"price\":50.78}],\"otherList\":[{\"aaa\":1,\"bbb\":\"Java\"},{\"aaa\":2,\"bbb\":\"PHP\"}],\"bookCountList\":[{\"categoryId\":1,\"bookCount\":11,\"categoryName\":\"Java\"},{\"categoryId\":2,\"bookCount\":22,\"categoryName\":\"PHP\"},{\"categoryId\":3,\"bookCount\":33,\"categoryName\":\"Python\"}]}}";

        //把复杂的 json 对象转化为 java 对象
        JsonExampleVo vo = JsonUtil.json2java(json, JsonExampleVo.class);

        //把 java 对象转化为 json 对象
        String newJson = JsonUtil.java2json(vo);

        //把复杂的 json 对象转化为 java 对象
        JsonExampleVo vo2 = JsonUtil.json2java(newJson, JsonExampleVo.class);

        System.out.println("");
        System.out.println("============================");
        System.out.println("11, toString = " + vo.toString());
        System.out.println("22, toString = " + vo2.toString());
        System.out.println("java, equals = " + vo.equals(vo2)); //true
        System.out.println("newJson = " + newJson);
        System.out.println("json, equals = " + newJson.equals(json)); //很可能是 false, 因为次序变了, 但是, 其实里面的内容是一样的
        System.out.println("============================");
        System.out.println("");
        System.out.println(mapper.enableDefaultTyping().writeValueAsString("{name:'eee','age':23,\"sex\":\"男\"}"));
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(Feature.ALLOW_SINGLE_QUOTES, true);
        mapper.configure(Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
        JsonNode df = mapper.readValue("{name:'eee','age':23,\"sex\":\"男\"}", JsonNode.class);
        System.out.println(df.toString());
    */}

}
