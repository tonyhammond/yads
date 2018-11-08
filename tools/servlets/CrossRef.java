
import java.io.*;
import java.util.*;

// Classes for regular expression handling
import org.apache.oro.text.perl.*;
import org.apache.oro.text.regex.*;

public class CrossRef {

  static private Perl5Util _re = new Perl5Util();
  static private MatchResult _match;

  static private Hashtable _dict = new Hashtable();

  static {

    // Academic Press, Churchill-Livingstone, Royal Society
    _dict.put("10.1006", "/^[a-z]{4}\\.\\d{4}\\.\\d{4}$/i");
    _dict.put("10.1054", "/^[a-z]{4}\\.\\d{4}\\.\\d{4}$/i");
    _dict.put("10.1098", "/^[a-z]{4}\\.\\d{4}\\.\\d{4}$/i");

    // W.B. Saunders
    _dict.put("10.1053", "/^[a-z]{4}\\.\\d{4}\\.\\d{4,}$/i");

    // Mosby
    _dict.put("10.1067", "/^[a-z]{3}\\.\\d{4}\\.\\d{5,}$/i");

    // Elsevier (PII)
    _dict.put("10.1016", "/^s?\\d{4}-\\d{4}\\(\\d{2}\\)\\d{5}-\\d$/i");

    // Springer
    _dict.put("10.1007", "/^\\d{12}$/i");

    // JBC
    _dict.put("10.1074", "/^jbc\\.\\S+$/i");

    // PNAS
    _dict.put("10.1073", "/^pnas\\.\\S+$/i");

    // Science
    _dict.put("10.1126", "/^science\\.\\S+$/i");

    // Blackwell, Munksgaard
    _dict.put("10.1034", "/^j\\.\\d{4}-\\d{3}[0-9x]\\.\\d{4}\\.\\S+\\.x$/i");
    _dict.put("10.1046", "/^j\\.\\d{4}-\\d{3}[0-9x]\\.\\d{4}\\.\\S+\\.x$/i");

    // World Scientific
    _dict.put("10.1142", "/^s\\d{7}\\w\\d{8}$/i");

    // NJPS
    _dict.put("10.1039", "/^[a-z]\\w+$/i");

    // IEE
    _dict.put("10.1049", "/^[a-z]{2}:\\d{8}$/i");

    // IEEE
    _dict.put("10.1109", "/^\\d+\\.\\d+$/i");

    // Wiley
    _dict.put("10.1002", "/^(\\(sici\\)\\S+|\\w+\\.\\d+(\\.abs)*)$/i");

    // Nature
    _dict.put("10.1038", "/^\\d+$/i");

    // ALPSP
    _dict.put("10.1087", "/^\\d{17}$/i");

    // OUP
    _dict.put("10.1093", "/^\\w+\\/\\d+\\.\\d+\\.\\w+$/i");

    // AMS
    _dict.put("10.1090", "/^s\\w{4}-\\w{4}-\\w{2}-\\w{5}-\\w$/i");

    // AGU
    _dict.put("10.1029", "/^\\d\\w+$/i");

    // ACS
    _dict.put("10.1021", "/^[a-z]{2}\\S+$/i");

    // RSC
    _dict.put("10.1039", "/^[a-z]\\w+$/i");

    // MAIK, AIP, ASA, SOR, AAPM, AAPT, ACMP, ASME, BMES, AVS, SPIE
    _dict.put("10.1134", "/^1\\.\\d+$/");
    _dict.put("10.1063", "/^1\\.\\d+$/");
    _dict.put("10.1121", "/^1\\.\\d+$/");
    _dict.put("10.1122", "/^1\\.\\d+$/");
    _dict.put("10.1118", "/^1\\.\\d+$/");
    _dict.put("10.1119", "/^1\\.\\d+$/");
    _dict.put("10.1120", "/^1\\.\\d+$/");
    _dict.put("10.1115", "/^1\\.\\d+$/");
    _dict.put("10.1114", "/^1\\.\\d+$/");
    _dict.put("10.1116", "/^1\\.\\d+$/");
    _dict.put("10.1117", "/^1\\.\\d+$/");

    // Taylor & Francis
    _dict.put("10.1080", "/^\\d+$/");

    // Pion
    _dict.put("10.1068", "/^[a-z]\\w+$/");

    // APA
    _dict.put("10.1037", "/^\\/\\d{4}-\\w{4}\\.\\d+\\.[0-9-]+\\.\\w+$/");

    // ASCE
    _dict.put("10.1061", "/^\\(asce\\)\\d{4}-\\w{4}\\(\\d{4}\\)\\d+:\\d+\\(\\d+\\)$/i");

    // APS
    _dict.put("10.1103", "/^physrev\\w\\.\\d+\\.\\d+$/i");

    // Portland Press
    _dict.put("10.1037", "/^\\d{4}-\\w{4}:\\d{7}$/i");

    // Turpion
    _dict.put("10.1070", "/^\\w{2}\\d{4}v\\d{3}n\\d{2}\\w{4}\\d{6}$/i");

    // Maryann Liebert
    _dict.put("10.1089", "/^1\\.\\d{15,}$/i");

    // IUC
    _dict.put("10.1107", "/^s\\w{16}$/i");

    // IOPP
    _dict.put("10.1088", "/^\\w{4}-\\w{4}\\/\\w+\\/\\w+\\/\\w+$/i");

    };
  

  static public String getCrossRefParent(String doi) {

    if (_re.match("/^(10\\.\\d{4})\\/(\\S+)$/i", doi)) {

      _match = _re.getMatch();
      return _getCrossRefParent(_match.group(1), _match.group(2));
    } else { 
      return "10.system/type.null";
    }
  }

  static public boolean hasCrossRefProfile(String doi) {

    if (_re.match("/^(10\\.\\d{4})\\/(\\S+)$/i", doi)) {

      _match = _re.getMatch();
      return _hasCrossRefProfile(_match.group(1), _match.group(2));
    } else {
      return false;
    }
  }

  static private String _getCrossRefParent(String _prefix, String _suffix) {

    if (_dict.containsKey(_prefix)) {
      if (_re.match("/^10\\.(1006|1053|1054)\\/(\\w{4})/", _prefix + "/" + _suffix)) {

        _match = _re.getMatch();
        return _prefix + "/" + _match.group(2);
      } else {
        return "1014/10.1000/system.type.null";
      }
    } else {
      return "1014/10.1000/system.type.null";
    }

  } 

  static private boolean _hasCrossRefProfile(String _prefix, String _suffix) {

    if (_dict.containsKey(_prefix)) {
      return _re.match((String)_dict.get(_prefix), _suffix);
    } else {
      return false;
    }

  } 

  public static void main(String args[]) {

    String doi = args[0];
    String doiParent = getCrossRefParent(doi);

    System.out.println("doi:" + doi + " has as parent doi:" + doiParent);

    if (hasCrossRefProfile(doi)) {
      System.out.println("doi:" + doi + " has a CrossRef profile");
    } else {
      System.out.println("doi:" + doi + " does not have a CrossRef profile");
    }

  }

}
