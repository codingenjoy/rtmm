Array.prototype.del=function(n){
	if(n<0){
	return this;
	}else{
		var a = this.slice(0,n);
		var b = this.slice(n+1,this.length);
		var c = a.concat(b);
		return c;
	}
};
Array.prototype.unique = function () {
    var temp = new Array();
      this.sort();
      for(var i = 0; i < this.length; i++) {
          if( this[i] == this[i+1]) {
            continue;
        }
          temp[temp.length]=this[i];
      }
      return temp;
	  
};
