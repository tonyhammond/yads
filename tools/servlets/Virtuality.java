import java.io.*;
import java.util.*;

public class Virtuality {

  static private Hashtable Virtuals = new Hashtable();

  static class Virtual {

    private Hashtable _dict = new Hashtable();
    private Vector _curV = new Vector();
  
    void newDataGroup() {

      Vector v = new Vector();
      _curV = v;
      _dict.put(_curV, _curV);

    }
  
    void addData(Object o) {
  
      _curV = (Vector)_dict.get(_curV);
      _curV.addElement(o);
      _dict.put(_curV, _curV);
    }

  
    Vector addDataGroup() {
  
      return (Vector)_dict.get(_curV);
    }

  }

  static {

    Virtual v = new Virtual(); 

    // DOI Global Registry for DOI Registries
    v.newDataGroup();
    v.addData(new String[] { "label", "DOI global registry" });
    v.addData(new String[] { "detail", "Global registry for DOI system registries" });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.type.null" });
    v.addData(new String[] { "child", "doi:10.1000/system.registry.agents" });
    v.addData(new String[] { "child", "doi:10.1000/system.registry.profiles" });
    v.addData(new String[] { "child", "doi:10.1000/system.registry.resolvers" });
    v.addData(new String[] { "child", "doi:10.1000/system.registry.schemas" });
    v.addData(new String[] { "child", "doi:10.1000/system.registry.types" });
    Virtuals.put("10.1000/system.registry.global", v.addDataGroup());

    // DOI Registration Agency Registry and Agents
    v.newDataGroup();
    v.addData(new String[] { "label", "DOI agent registry" });
    v.addData(new String[] { "detail", "Registry for registered DOI agents" });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.global" });
    v.addData(new String[] { "child", "doi:10.1000/system.agent.default" });
    v.addData(new String[] { "child", "doi:10.1000/system.agent.pila" });
    Virtuals.put("10.1000/system.registry.agents", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "IDF" });
    v.addData(new String[] { "detail", "Default DOI agent - the International DOI Foundation." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.agents" });
    Virtuals.put("10.1000/system.agent.default", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "PILA" });
    v.addData(new String[] { "detail", "Publishers International Linking Association." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.agents" });
    v.addData(new String[] { "resource", "http://www.crossref.org" });
    Virtuals.put("10.1000/system.agent.pila", v.addDataGroup());

    // DOI Schema Registry and Schemas
    v.newDataGroup();
    v.addData(new String[] { "label", "DOI schema registry" });
    v.addData(new String[] { "detail", "Registry for registered DOI schemas" });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.global" });
    v.addData(new String[] { "child", "doi:10.1000/system.schema.2001-07-26" });
    Virtuals.put("10.1000/system.registry.schemas", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "DOI System schema" });
    v.addData(new String[] { "detail", "DOI Suystem schema." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.schemas" });
    Virtuals.put("10.1000/system.schema.2001-07-12", v.addDataGroup());

    // DOI Server Registry and Servers
    v.newDataGroup();
    v.addData(new String[] { "label", "DOI resolver registry" });
    v.addData(new String[] { "detail", "Registry for registered DOI resolvers." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.global" });
    v.addData(new String[] { "child", "doi:10.1000/system.resolver.dx" });
    v.addData(new String[] { "child", "doi:10.1000/system.resolver.yads" });
    Virtuals.put("10.1000/system.registry.resolvers", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "DOI Proxy" });
    v.addData(new String[] { "detail", "Default DOI resolver - the 'DOI Proxy Server'." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.resolvers" });
    v.addData(new String[] { "resolver", "http://dx.doi.org" });
    Virtuals.put("10.1000/system.resolver.dx", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "YADS" });
    v.addData(new String[] { "detail", "Yet Another DOI Service." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.resolvers" });
    v.addData(new String[] { "resolver", "http://dx.doi.org/1014/yads" });
    v.addData(new String[] { "schema", "http://dx.doi.org/1014/yads.xsd" });
    Virtuals.put("10.1000/system.resolver.yads", v.addDataGroup());

    // DOI Profile Registry and Profiles
    v.newDataGroup();
    v.addData(new String[] { "label", "DOI Profile Registry" });
    v.addData(new String[] { "detail", "Registry for DOI Application Profiles." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.global" });
    v.addData(new String[] { "child", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "child", "doi:10.1000/system.profile.zero" });
    v.addData(new String[] { "child", "doi:10.1000/system.profile.base" });
    v.addData(new String[] { "child", "doi:10.1000/system.profile.crossref" });
    Virtuals.put("10.1000/system.registry.profiles", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "System Profile" });
    v.addData(new String[] { "detail", "System profile - The DOI system profile for system DOIs." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.profiles" });
    v.addData(new String[] { "agent", "doi:10.1000/system.agent.default" });
    v.addData(new String[] { "genre", "Void" });
    Virtuals.put("10.1000/system.profile.system", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "Zero Profile" });
    v.addData(new String[] { "detail", "Zero profile - A DOI application profile for legacy DOIs with no kernel metadata." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.profiles" });
    v.addData(new String[] { "agent", "doi:10.1000/system.agent.default" });
    v.addData(new String[] { "genre", "Any" });
    Virtuals.put("10.1000/system.profile.zero", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "Base Profile" });
    v.addData(new String[] { "detail", "Base profile - A DOI application profile for DOIs with only kernel metadata." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.profiles" });
    v.addData(new String[] { "agent", "doi:10.1000/system.agent.default" });
    v.addData(new String[] { "genre", "Any" });
    Virtuals.put("10.1000/system.profile.base", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "CrossRef Profile" });
    v.addData(new String[] { "detail", "CrossRef profile - A DOI application profile for the CrossRef application which resolves journal article DOIs from bibliographic metadata queries." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.profiles" });
    v.addData(new String[] { "agent", "doi:10.1000/system.agent.pila" });
    v.addData(new String[] { "genre", "Scholarly Journal Article" });
    // v.addData(new String[] { "resolver", "http://query-test.crossref.org/query/xref.cgi" });
    v.addData(new String[] { "resolver", "http://query.crossref.org/tony/xref.cgi" });
    v.addData(new String[] { "schema", "http://www.crossref.org/docs/doi_batch.dtd" });
    Virtuals.put("10.1000/system.profile.crossref", v.addDataGroup());

    // DOI Type Registry and Types
    v.newDataGroup();
    v.addData(new String[] { "label", "DOI type registry" });
    v.addData(new String[] { "detail", "Registry for registered DOI handle types." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.global" });

    // Type-specific types
    v.addData(new String[] { "child", "doi:10.1000/system.type.null" });
    v.addData(new String[] { "child", "doi:10.1000/system.type.type" });

    // Object-specific types
    v.addData(new String[] { "child", "doi:10.1000/system.type.alias" });
    v.addData(new String[] { "child", "doi:10.1000/system.type.relation" }); //*

    // Application-specific types
    v.addData(new String[] { "child", "doi:10.1000/system.type.agent" });
    v.addData(new String[] { "child", "doi:10.1000/system.type.profile" });
    v.addData(new String[] { "child", "doi:10.1000/system.type.schema" });

    // Resource-specific types
    v.addData(new String[] { "child", "doi:10.1000/system.type.access" });
    v.addData(new String[] { "child", "doi:10.1000/system.type.detail" });
    v.addData(new String[] { "child", "doi:10.1000/system.type.label" });
    v.addData(new String[] { "child", "doi:10.1000/system.type.resource" });
    v.addData(new String[] { "child", "doi:10.1000/system.type.service" });

    Virtuals.put("10.1000/system.registry.types", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "X-DOI_ACCESS" });
    v.addData(new String[] { "detail", "Handle type 'X-DOI_ACCESS' - value is string literal giving resource access point." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.types" });
    v.addData(new String[] { "type", "hdl:0.type/X-DOI_ACCESS" });
    Virtuals.put("10.1000/system.type.access", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "X-DOI_AGENT" });
    v.addData(new String[] { "detail", "Handle type 'X-DOI_AGENT' - value is URI for a DOI agent" });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.types" });
    v.addData(new String[] { "type", "hdl:0.type/X-DOI_AGENT" });
    Virtuals.put("10.1000/system.type.agent", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "X-DOI_ALIAS" });
    v.addData(new String[] { "detail", "Handle type 'X-DOI_ALIAS' - value is URI for a DOI alias (equivalent to 'HS_ALIAS')." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.types" });
    v.addData(new String[] { "type", "hdl:0.type/X-DOI_ALIAS" });
    Virtuals.put("10.1000/system.type.alias", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "X-DOI_DETAIL" });
    v.addData(new String[] { "detail", "Handle type 'X-DOI_DETAIL' - value is string literal giving full resource details" });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.types" });
    v.addData(new String[] { "type", "hdl:0.type/X-DOI_DETAIL" });
    Virtuals.put("10.1000/system.type.detail", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "X-DOI_LABEL" });
    v.addData(new String[] { "detail", "Handle type 'X-DOI_LABEL' - value is string literal with descriptive label for resource." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.types" });
    v.addData(new String[] { "type", "hdl:0.type/X-DOI_LABEL" });
    Virtuals.put("10.1000/system.type.label", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "X-DOI_NULL" });
    v.addData(new String[] { "detail", "Handle type 'X-DOI_NULL' - value is empty string literal." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.types" });
    v.addData(new String[] { "type", "hdl:0.type/X-DOI_NULL" });
    Virtuals.put("10.1000/system.type.null", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "X-DOI_PROFILE" });
    v.addData(new String[] { "detail", "Handle type 'X-DOI_PROFILE' - value is URI for DOI application profile." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.types" });
    v.addData(new String[] { "type", "hdl:0.type/X-DOI_PROFILE" });
    Virtuals.put("10.1000/system.type.profile", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "X-DOI_RELATION" });
    v.addData(new String[] { "detail", "Handle type 'X-DOI_RELATION' - value is URI for related object." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.types" });
    v.addData(new String[] { "type", "hdl:0.type/X-DOI_RELATION" });
    Virtuals.put("10.1000/system.type.relation", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "X-DOI_ROLE" });
    v.addData(new String[] { "detail", "Handle type 'X-DOI_ROLE' - value is string literal for DOI type role." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.types" });
    v.addData(new String[] { "type", "hdl:0.type/X-DOI_ROLE" });
    Virtuals.put("10.1000/system.type.role", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "X-DOI_SCHEMA" });
    v.addData(new String[] { "detail", "Handle type 'X-DOI_SCHEMA' - value is URI for DOI application metadata schema." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.types" });
    v.addData(new String[] { "type", "hdl:0.type/X-DOI_SCHEMA" });
    Virtuals.put("10.1000/system.type.schema", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "X-DOI_SERVICE" });
    v.addData(new String[] { "detail", "Handle type 'X-DOI_SERVICE' - value is URI for a DOI service." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.types" });
    v.addData(new String[] { "type", "hdl:0.type/X-DOI_SERVICE" });
    Virtuals.put("10.1000/system.type.service", v.addDataGroup());

    // 
    v.newDataGroup();
    v.addData(new String[] { "label", "X-DOI_TYPE" });
    v.addData(new String[] { "detail", "Handle type 'X-DOI_TYPE' - value is URI of handle for DOI handle type as registered under '0.type' naming authority." });
    v.addData(new String[] { "profile", "doi:10.1000/system.profile.system" });
    v.addData(new String[] { "parent", "doi:10.1000/system.registry.types" });
    v.addData(new String[] { "type", "hdl:0.type/X-DOI_TYPE" });
    Virtuals.put("10.1000/system.type.type", v.addDataGroup());

  }

  static public boolean isVirtual(String s) {

    return Virtuals.containsKey(s);

  }

  static public void setVirtual(String s, Vector v) {

    Virtuals.put(s, v);

  }

  static public Vector getVirtual(String s) {

    return (Vector)Virtuals.get(s);

  }

  static public Enumeration getVirtualElements() {

    return (Enumeration)Virtuals.keys();

  }

  public static void main(String args[]) {

    Vector vec = new Vector();

    for (Enumeration e = getVirtualElements(); e.hasMoreElements(); ) {
      vec = getVirtual((String)e.nextElement());
      for (Enumeration e1 = vec.elements(); e1.hasMoreElements(); ) {
        String[] p = (String[])e1.nextElement();
        System.out.println(p[0] + " => " + p[1]);
      }
      System.out.println();
    }
  }

}
