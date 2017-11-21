/*
 * HashMap version 3.0
 * HashMap���캯��
*/
function JHashMap()
{
    this.length = 0;
    this.prefix = "hashmap_prefix_20120420_";
}
/**
 * ��HashMap����Ӽ�ֵ��
 */
JHashMap.prototype.put = function (key, value)
{
   
    this[this.prefix + key] = value;
    this.length ++;
}
/**
 * ��HashMap�л�ȡvalueֵ
 */
JHashMap.prototype.get = function(key)
{
    return typeof this[this.prefix + key] == "undefined" 
            ? null : this[this.prefix + key];
}
/**
 * ��HashMap�л�ȡ����key�ļ��ϣ���������ʽ����
 */
JHashMap.prototype.keySet = function()
{
    var arrKeySet = new Array();
    var index = 0;
    for(var strKey in this)
    {
        if(strKey.substring(0,this.prefix.length) == this.prefix)
            arrKeySet[index ++] = strKey.substring(this.prefix.length);
    }
    return arrKeySet.length == 0 ? null : arrKeySet;
}
/**
 * ��HashMap�л�ȡvalue�ļ��ϣ���������ʽ����
 */
JHashMap.prototype.values = function()
{
    var arrValues = new Array();
    var index = 0;
    for(var strKey in this)
    {
        if(strKey.substring(0,this.prefix.length) == this.prefix)
            arrValues[index ++] = this[strKey];
    }
    return arrValues.length == 0 ? null : arrValues;
}
/**
 * ��ȡHashMap��valueֵ����
 */
JHashMap.prototype.size = function()
{
    return this.length;
}
/**
 * ɾ��ָ����ֵ
 */
JHashMap.prototype.remove = function(key)
{
    delete this[this.prefix + key];
    this.length --;
}
/**
 * ���HashMap
 */
JHashMap.prototype.clear = function()
{
    for(var strKey in this)
    {
        if(strKey.substring(0,this.prefix.length) == this.prefix)
            delete this[strKey];   
    }
    this.length = 0;
}
/**
 * �ж�HashMap�Ƿ�Ϊ��
 */
JHashMap.prototype.isEmpty = function()
{
    return this.length == 0;
}
/**
 * �ж�HashMap�Ƿ����ĳ��key
 */
JHashMap.prototype.containsKey = function(key)
{
    for(var strKey in this)
    {
       if(strKey == this.prefix + key)
          return true;  
    }
    return false;
}
/**
 * �ж�HashMap�Ƿ����ĳ��value
 */
JHashMap.prototype.containsValue = function(value)
{
    for(var strKey in this)
    {
       if(this[strKey] == value)
          return true;  
    }
    return false;
}
/**
 * ��һ��HashMap��ֵ���뵽��һ��HashMap�У�����������HashMap
 */
JHashMap.prototype.putAll = function(map)
{
    if(map == null)
        return;
    if(map.constructor != JHashMap)
        return;
    var arrKey = map.keySet();
    var arrValue = map.values();
    for(var i in arrKey)
       this.put(arrKey[i],arrValue[i]);
}
//toString
JHashMap.prototype.toString = function()
{
    var str = "";
    for(var strKey in this)
    {
        if(strKey.substring(0,this.prefix.length) == this.prefix)
              str += strKey.substring(this.prefix.length) 
                  + " : " + this[strKey] + "\r\n";
    }
    return str;
}