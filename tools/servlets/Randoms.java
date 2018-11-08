
import java.io.*;
import java.lang.*;
import java.util.*;

public class Randoms {

  static private Hashtable _dict = new Hashtable();

  static private Random _r = new Random();

  static public String getNext() {

    int _key = _r.nextInt();
    _key = Math.abs(_key);
    _key = _key % _dict.size();
    // _key += 1;
    return (String)_dict.get(Integer.toString(_key));

  }

  static {

    int i = 0;

    _dict.put(Integer.toString(i++), "10.1000/1");
    _dict.put(Integer.toString(i++), "10.1000/2");
    _dict.put(Integer.toString(i++), "10.1000/3");
    _dict.put(Integer.toString(i++), "10.1000/4");
    _dict.put(Integer.toString(i++), "10.1000/5");
    _dict.put(Integer.toString(i++), "10.1045/january2001-contents");
    _dict.put(Integer.toString(i++), "10.1045/february2001-contents");
    _dict.put(Integer.toString(i++), "10.1045/march2001-contents");
    _dict.put(Integer.toString(i++), "10.1045/april2001-contents");
    _dict.put(Integer.toString(i++), "10.1045/may2001-contents");
    _dict.put(Integer.toString(i++), "10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "10.1045/july2001-contents");
    _dict.put(Integer.toString(i++), "10.1045/july2001-contents");
    _dict.put(Integer.toString(i++), "10.1045/july2001-contents");
    _dict.put(Integer.toString(i++), "10.1045/july2001-contents");
    _dict.put(Integer.toString(i++), "10.1045/july2001-contents");
    _dict.put(Integer.toString(i++), "10.1045/july2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2000.4984");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2001.5293");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2000.4984");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2001.5293");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2000.4984");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2001.5293");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2000.4984");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2001.5293");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2000.4984");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2001.5293");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2000.4984");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2001.5293");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2000.4984");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2001.5293");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2000.4984");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2001.5293");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2000.4984");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2001.5293");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2000.4984");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2001.5293");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2000.4984");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2001.5293");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2000.4984");
    _dict.put(Integer.toString(i++), "1014/10.1006/abio.2001.5293");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "1014/10.1045/june2001-contents");
    _dict.put(Integer.toString(i++), "10.1118/1.1320060");
    _dict.put(Integer.toString(i++), "10.1119/1.1313524");
    _dict.put(Integer.toString(i++), "10.1006/geno.2000.6381");
    _dict.put(Integer.toString(i++), "10.1120/1.308254");
    _dict.put(Integer.toString(i++), "10.1029/1999GL008378");
    _dict.put(Integer.toString(i++), "10.1063/1.1326061");
    _dict.put(Integer.toString(i++), "10.1087/09531510050162101");
    _dict.put(Integer.toString(i++), "10.1021/bi0010468");
    _dict.put(Integer.toString(i++), "10.1063/1.1310599");
    _dict.put(Integer.toString(i++), "10.1090/S0002-9939-00-05489-7");
    _dict.put(Integer.toString(i++), "10.1037//0278-7393.1.4.501");
    _dict.put(Integer.toString(i++), "10.1061/(ASCE)1052-3928(1999)125:1(32)");
    _dict.put(Integer.toString(i++), "10.1121/1.1316097");
    _dict.put(Integer.toString(i++), "10.1115/1.1287590");
    _dict.put(Integer.toString(i++), "10.1116/1.1290371");
    _dict.put(Integer.toString(i++), "10.1046/j.1463-5224.2000.00140.x");
    _dict.put(Integer.toString(i++), "10.1114/1.1313775");
    _dict.put(Integer.toString(i++), "10.1054/ceca.2000.0162");
    _dict.put(Integer.toString(i++), "10.1016/S0304-4017(00)00375-7");
    _dict.put(Integer.toString(i++), "10.1049/el:19980069");
    _dict.put(Integer.toString(i++), "10.1109/16.658821");
    _dict.put(Integer.toString(i++), "10.1107/S0108270100012993");
    _dict.put(Integer.toString(i++), "10.1088/1464-4266/2/5/310");
    _dict.put(Integer.toString(i++), "10.1074/jbc.M004545200");
    _dict.put(Integer.toString(i++), "10.1002/1520-6807(200011)37:6<523::AID-PITS5>3.0.CO;2-W");
    _dict.put(Integer.toString(i++), "10.1134/1.1329703");
    _dict.put(Integer.toString(i++), "10.1089/15209150050194297");
    _dict.put(Integer.toString(i++), "10.1067/mai.2000.110800");
    _dict.put(Integer.toString(i++), "10.1034/j.1399-3089.2000.00081.x");
    _dict.put(Integer.toString(i++), "10.1038/80892");
    _dict.put(Integer.toString(i++), "10.1093/toxsci/57.1.95");
    _dict.put(Integer.toString(i++), "10.1068/p3001");
    _dict.put(Integer.toString(i++), "10.1073/pnas.97.21.11415");
    _dict.put(Integer.toString(i++), "10.1042/0264-6021:3520233");
    _dict.put(Integer.toString(i++), "10.1039/a906307b");
    _dict.put(Integer.toString(i++), "10.1126/science.289.5487.2137");
    _dict.put(Integer.toString(i++), "10.1122/1.1308521");
    _dict.put(Integer.toString(i++), "10.1117/1.1313768");
    _dict.put(Integer.toString(i++), "10.1007/s002689900668");
    _dict.put(Integer.toString(i++), "10.1080/109374000436364");
    _dict.put(Integer.toString(i++), "10.1103/PhysRevE.62.1457");
    _dict.put(Integer.toString(i++), "10.1098/rstb.2000.0723");
    _dict.put(Integer.toString(i++), "10.1070/RD1998v003n04ABEH000095");
    _dict.put(Integer.toString(i++), "10.1053/jscd.2000.16190");
    _dict.put(Integer.toString(i++), "10.1142/S0217751X00000409");
    
  }

  public static void main(String[] argv) {
  
    System.out.println(Randoms.getNext());

  }

}
