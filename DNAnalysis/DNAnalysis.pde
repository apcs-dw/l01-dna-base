//random DNA sequence generator: https://www.bioinformatics.org/sms2/random_dna.html
//therse imports are needed to read from a file.
import java.io.*;
import java.util.*;

String s0 = "tcgcagctcgaaccactatc";
String s1 = "agcgtcgagcttggttatac";
String s2 = "atcgtccagctatatcatac";
String s3 = "caatcacctcagtatcgcga";

String protein0 = "atgtcgcagctcgaaccactgtga";
String protein1 = "tcgatgcagctcgaaccactgtag";
String protein2 =   "agatgcgtcgagcttggttatcttgctaac";
String noProtein0 = "tcgatgcagctcgaaccactg";
String noProtein1 = "tcgcagctcgaaccactgtag";
String noProtein2 = "tcgtagcagctcgaaccactgatg";
String noProtein3 = "atgtcgcagtaactcgaaccactg";
String noProtein4 = "tcgatgcagctcgaacactgtag";

String bigStrand =  s0 + s1 + protein0 + s2 + protein1 + s3 + protein2;

int NUC_SIZE = 4;
String START_CODON = "atg";
int STAT_SIZE = 30;

void setup() {
  size(810, 500);
  background(0);

  //This will take the data from the provided file and load it into a String.
  //The readFile method is defined below, but you are not currently
  //resible for its content.
  bigStrand = readFile("dna_sample.txt");
  drawProtein(bigStrand, 0, 100, NUC_SIZE, false);
  displayStats(bigStrand);
}//setup



/*=====================================
getProtein(String strand)

Find the indices of the start and end codons in strand.
If strand does not contain a start or end, return ""
If the number of neucleotides between start and end
is not a multiple of 3, return ""
If there are not at least 5 consdons between start and
end, return ""
Otherwise, return the neucleotide sequence encoding a
protein, not including the start and end codons.
=====================================*/
String getProtein(String strand) {
  return "";
}//getProtein


/*=====================================
countProteins(String dna)

Returns the number of protein sequences in dna.
Prints out each found protein.
=====================================*/
int countProteins(String dna) {
  int proteinCount = 0;

  return proteinCount;
}//getProteins

/*=====================================
displayStats(String dna)

Display various stats about dna to the screen.
Set the following variables correctly:
  int neucleotideCount: Total number of neucleotides
  int codonCount: Total number of codons
  int proteinCount: Total count of proteins.
=====================================*/
void displayStats(String dna) {

}//displayStats

/*=====================================
highLightSequence(int x, int y, int startPos,
                  int sequenceLength, int sz, color c)

Draw sequenceLength amount of squares with size sz and color c
underneath a corresponding dna strand. The squares should
highlight the neucleotide sequence starting at startPos
that is sequenceLength long.
(x, y) represents the absolute start position of the larger
dna strand.
=====================================*/
void highLightSequence(int x, int y, int startPos, int sequenceLength, int sz, color c) {

}//highLightCodon

/*=====================================
drawProtein(String dna, int x, int y, int sz)

call drawStrand
Then go through dna and call highLightSequence
for every protein.
  draw green squares under the start codons
  draw red squares under the end codons
  draw yellow squares under the protein
  codons between the start and end.
=====================================*/
void drawProtein(String dna, int x, int y, int sz, boolean showChar) {

}//drawProtein



/*=====================================
  The following functions:
    int findProteinEnd(String strand, int start)
    boolean containsProtein(String strand)
    void drawStrand(String dna, int x, int y, int sz, boolean showChar)
    void drawBase(char base, int x, int y, int sz, boolean showChar)
    color charToColor(char c)
    String readFile(String fname)
  Were part of previous assignments. They are included here to assist in the lab.
=====================================*/
int findProteinEnd(String strand, int start) {

  strand = strand.substring(start, strand.length());
  int end0 = strand.indexOf("taa");
  int end1 = strand.indexOf("tga");
  int end2 = strand.indexOf("tag");

  //if no end, return -1
  if (end0 + end1 + end2 == -3) {
    return -1;
  }//no end codon

  //if any are not found, set them to a larger value that is possible
  if (end0 == -1) {
    end0 = strand.length() + start;
  }
  if (end1 == -1) {
    end1 = strand.length() + start;
  }
  if (end2 == -1) {
    end2 = strand.length() + start;
  }
  //the end is the smallest value of the three now.
  return min(end0, end1, end2) + start;
}//findProteinEnd

boolean containsProtein(String strand) {
  int start = strand.indexOf("atg");
  int end = findProteinEnd(strand, start);

  println("contains: (" + start + " " + end + ")");

  if (start == -1 || end == -1) {
    return false;
  }//missing start or end

  int sequenceLength = end - start;
  //if not a multiple of 3, there are "loose" nucleotides
  if (sequenceLength % 3 != 0) {
    return false;
  }//invalid length

  //need to have at least 5 codons, or
  //15 nucleaotides, between start and end
  return sequenceLength >= 15;
}//containsExon

void drawStrand(String dna, int x, int y, int sz, boolean showChar) {
  textAlign(CENTER, CENTER);
  dna = dna.toUpperCase();
  for (int i=0; i<dna.length(); i++) {
    drawBase(dna.charAt(i), x, y, sz, showChar);
    x+= sz;
    if (x+sz > width) {
      x = 0;
      y+= sz*2;
    }
  }//loop through chars
}//drawStrand

void drawBase(char base, int x, int y, int sz, boolean showChar) {
  noStroke();
  fill(charToColor(base));
  square(x, y, sz);

  if (showChar) {
    fill(255);
    textSize(sz);
    text(base, x+sz/2, y+sz/2);
  }
}//drawBase


color charToColor(char c) {
  color col = color(0);
  if (c == 'A') {
    col = #fa3737;//#F5793A;
  }
  else if (c == 'T') {
    col = #7c0000;//#A95AA1;
  }
  else if (c == 'C') {
    col = #85C0F9;
  }
  else if (c == 'G') {
    col = #0F2080;
  }
  return col;
}//charTocolor


String readFile(String fileName) {
  String text = "";
  File f = new File(sketchPath(fileName));
  try {
    Scanner s = new Scanner(f);
    text = s.nextLine();
  }
  catch (IOException e) {
    System.out.println("File not found!");
  }
  return text;
}//readFile
