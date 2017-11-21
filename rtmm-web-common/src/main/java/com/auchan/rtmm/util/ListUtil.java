package com.auchan.rtmm.util;

import java.util.ArrayList;
import java.util.List;

public class ListUtil {
	//去掉集合中重复的数据，并返回集合,仅支持简单字符类型
		 public static List clearIterant(List list){
		   // int sum=0;//计算有多少俱不同的
		    List lists=new ArrayList();
		    for(int i=0;i<list.size();i++){
		     boolean is=true;//比较原理：将其中的一个数和其它任意一个数进行比较
		     for(int j=i+1;j<list.size();j++){
		      if(list.get(i).equals(list.get(j))){
		       is=false;//如果相同了，就直接断掉循环，进行下一次的比较
		       break;
		      }
		     }
		     if(is){//只有和任意一个数都不相同才记录下来
		     // sum++;
		     // System.out.print(list.get(i)+" ");
		      lists.add(list.get(i));
		     }
		    }
		   // System.out.println(" 共有"+sum+"个。");
		    return lists;
		 }
		 
		 
}
