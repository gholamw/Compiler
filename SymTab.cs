using System;
 
namespace Tastier { 

public class Obj { // properties of declared symbol
   public string name; // its name
   public int kind;    // var, proc or scope
   public int type;    // its type if var (undef for proc)
   public int length;
   public int level;   // lexic level: 0 = global; >= 1 local
   public int adr;     // address (displacement) in scope 
   public Obj next;    // ptr to next object in scope
   // for scopes
   public Obj outer;   // ptr to enclosing scope
   public Obj locals;  // ptr to locally declared objects
   public int nextAdr; // next free address in scope
}

public class SymbolTable {

   const int // object kinds
      var = 0, proc = 1, scope = 2, array = 6; 

   const int // types
      undef = 0, integer = 1, boolean = 2;

   public Obj topScope; // topmost procedure scope
   public int curLevel; // nesting level of current scope
   public Obj undefObj; // object node for erroneous symbols

   public bool mainPresent;
   
   Parser parser;
   
   public SymbolTable(Parser parser) {
      curLevel = -1; 
      topScope = null;
      undefObj = new Obj();
      undefObj.name = "undef";
      undefObj.kind = var;
      undefObj.type = undef;
      undefObj.level = 0;
      undefObj.adr = 0;
      undefObj.next = null;
      this.parser = parser;
      mainPresent = false;
   }

// open new scope and make it the current scope (topScope)
   public void OpenScope() {
      Obj scop = new Obj();
      scop.name = "";
      scop.kind = scope; 
      scop.outer = topScope; 
      scop.locals = null;
      scop.nextAdr = 0;
      topScope = scop; 
      curLevel++;
   }

// close current scope
   public void CloseScope () {
     Obj j, scp; 
     
     scp = topScope;
     while(scp != null){
        j = scp.locals;
        while(j != null){
          
           
         string theKind = " ";
         string theType = " ";
         string theLevel = " ";
         
         if(j.level >= 1)
         {
            theLevel = "local";
         }
         else
         {
            theLevel = "global";
         }
         
         if(j.type == 1)
         {
            theType = "int";
         }
         else if (j.type == 2)
         {
            theType = "boolean";
         }
         else
         {
            theType = "void";
         }
         
         if(j.kind == 0)
         {
            theKind = "variable";
         }
         else if(j.kind == 1)
         {
            theKind = "process";
         }
         else if(j.kind == 2)
         {
            theKind = "scope";
         }
         else if(j.kind == 6)
         {
            theKind = "array";
         }
           
         Console.WriteLine(" ; " + theKind + " " + theLevel + " " + theType + " " + j.name);  
          
           j = j.next;
        }
      scp = scp.outer;
     }
      curLevel--;
     
   }

// open new sub-scope and make it the current scope (topScope)
   public void OpenSubScope() {
   // lexic level remains unchanged
      Obj scop = new Obj();
      scop.name = "";
      scop.kind = scope;
      scop.outer = topScope;
      scop.locals = null;
   // next available address in stack frame remains unchanged
      scop.nextAdr = topScope.nextAdr;
      topScope = scop;
   }

// close current sub-scope
   public void CloseSubScope() {
   // update next available address in enclosing scope
      topScope.outer.nextAdr = topScope.nextAdr;
   // lexic level remains unchanged
      topScope = topScope.outer;
   }

   public void growStack(){
      topScope.nextAdr++;
   }

// create new object node in current scope
   public Obj NewObj(string name, int kind, int type) {
      Obj p, last; 
      Obj obj = new Obj();
      obj.name = name; obj.kind = kind;
      obj.type = type; obj.level = curLevel; 
      obj.next = null; 
      p = topScope.locals; last = null;
      while (p != null) { 
         if (p.name == name)
            parser.SemErr("name declared twice");
         last = p; p = p.next;
      }
      if (last == null)
         topScope.locals = obj; else last.next = obj;
      if (kind == var)
         obj.adr = topScope.nextAdr++;
      return obj;
   }

   // create new array object node in current scope
   public Obj NewArrayObj(string name, int kind, int type, int length) 
   {
      Obj p, last; 
      Obj obj = new Obj();
      obj.name = name; obj.kind = kind;
      obj.type = type; obj.level =  curLevel; 
      obj.next = null; 
      obj.length = length;
      p = topScope.locals; last = null;
      while (p != null) { 
         if (p.name == name)
            parser.SemErr("name declared twice");
         last = p; p = p.next;
      }
      if (last == null)
         topScope.locals = obj; else last.next = obj;
      if (kind == var)
         obj.adr = topScope.nextAdr++;
      return obj;
   }

// search for name in open scopes and return its object node
   public Obj Find(string name) {
      Obj obj, scope;
      scope = topScope;
      while (scope != null) { // for all open scopes
         obj = scope.locals;
         while (obj != null) { // for all objects in this scope
            if (obj.name == name) return obj;
            obj = obj.next;
         }
         scope = scope.outer;
      }
      parser.SemErr(name + " is undeclared");
      return undefObj;
   }

} // end SymbolTable

} // end namespace
