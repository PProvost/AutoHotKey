import java.util.Scanner;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

class Main {
  public static void main(String[] args) throws IOException {
    String text;
    int splitSize = 6;
    Scanner keyboard = new Scanner(System.in);
    System.out.println("Paste your string");
    text = keyboard.nextLine();
    System.out.println(text);
    String[] textArray = text.split(" ", -2);
    //Clears console
    System.out.print("\033\143");
    File ahkOutput = new File("ahkOutput.txt");
    FileWriter writing = new FileWriter("ahkOutput.txt");
    //Prints ready for ahk
    for(String a : textArray){
      System.out.println("Send, " + a + "{space}");
      writing.write("Send, " + a + "{space}\n");
    }
    writing.close();
  }
}
