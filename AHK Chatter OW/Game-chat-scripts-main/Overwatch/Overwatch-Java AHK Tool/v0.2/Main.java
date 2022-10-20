import java.util.Scanner;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.FileReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.BufferedWriter;
import java.io.BufferedReader;
import java.io.InputStreamReader;

class Main {

  public static void main(String[] args) throws IOException {

    String ogInput;
    char key;
    int splitSize = 0, passer = 4;
    Scanner keyboard = new Scanner(System.in);
    System.out.println("What ctrl + key would you to use? ");
    key = keyboard.next().charAt(0);
    System.out.println("Paste your string");
    keyboard.nextLine();
    ogInput = keyboard.nextLine();
    System.out.println(ogInput);
    String[] ahkText = ogInput.split(" ", -2);
    String[] ahkComment = ogInput.split("\\.", -2);
    char[] ahkChar = new char[ogInput.length()];
    // Clears console
    System.out.print("\033\143");
    File ahkOutput = new File("ahkOutput.txt");
    File commentOutput = new File("commentOutput.txt");
    FileWriter writing = new FileWriter("ahkOutput.txt");
    writing.write(
        "#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases. \n; #Warn  ; Enable warnings to assist with detecting common errors. \nSendMode Input  ; Recommended for new scripts due to its superior speed and reliability. \nSetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.\n\n"
            + "^" + key + "::");

    // Prints and writes ready for ahk
    int counter = 0;
    for (String a : ahkText) {
      System.out.println("Send, " + a + "{space}");
      writing.write("Send, " + a + "{space}\n");
      counter++;
      if (counter % 24 == 0) {
        writing.write("\nSleep, 3000\nSend, {tab}{enter}\nSleep, 4000\nSend, {tab}{enter}\nSleep, 3000\n");
      }
    }
    writing.write("\nreturn");
    writing.close();
    /*
     * for(String b : ahkComment){
     * comment.write("; " + b + " ");
     * }
     */
    FileWriter comment = new FileWriter("commentOutput.txt");
    for (int i = 0; i < ahkComment.length - 1; i++) {
      if (passer % 4 == 0) {
        passer = 0;
        comment.write("\n; " + ahkComment[i] + " ");
      } else {
        passer++;
        comment.write(ahkComment[i] + " ");
      }
    }

    comment.close();
    File newTest = new File("newTest.txt");
    // copyContent(commentOutput, newTest);
    File[] combiner = new File[2];
    combiner[1] = ahkOutput;
    combiner[0] = commentOutput;
    mergeFiles(combiner, newTest);
    // copyContent(ahkOutput, newTest);
    FileWriter qwrite = new FileWriter("newTest.txt");
    qwrite.write("\nreturn");
    qwrite.close();
  }

  public static void mergeFiles(File[] files, File mergedFile) {

    FileWriter fstream = null;
    BufferedWriter out = null;
    try {
      fstream = new FileWriter(mergedFile, true);
      out = new BufferedWriter(fstream);
    } catch (IOException e1) {
      e1.printStackTrace();
    }

    for (File f : files) {
      System.out.println("merging: " + f.getName());
      FileInputStream fis;
      try {
        fis = new FileInputStream(f);
        BufferedReader in = new BufferedReader(new InputStreamReader(fis));

        String aLine;
        while ((aLine = in.readLine()) != null) {
          out.write(aLine);
          out.newLine();
        }

        in.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
    }

    try {
      out.close();
    } catch (IOException e) {
      e.printStackTrace();
    }

  }
}