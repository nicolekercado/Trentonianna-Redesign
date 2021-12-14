import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class TextFileToString {
	//Converts the text file into a formatted string.
	public static String readFileAsString(String filePath) throws IOException {

		BufferedReader br = new BufferedReader(new FileReader(filePath));
		StringBuilder sb = new StringBuilder();

		String line = br.readLine();
		while (line != null) {
			sb.append(line).append("\n");
			line = br.readLine();
		}

		String fileAsString = sb.toString();

		br.close();

		return fileAsString;
	}
	
	//Using this method, when we print out the returned string, it will include all of the
	//newlines in the printed out string, whereas with the first readFileAsString() method, 
	//when it's printed out, the newlines will be printed out as newlines rather than as \n
	//which we will need when actually inserting the Transcript text into the database.
	public static String readFileAsString2(String filePath) throws IOException {

		BufferedReader br = new BufferedReader(new FileReader(filePath));
		StringBuilder sb = new StringBuilder();

		String line = br.readLine();
		while (line != null) {
			sb.append(line).append("\\n");
			line = br.readLine();
		}
		
		String fileAsString = sb.toString();
		
		br.close();
		
		//Make it SQL Compatible
		for (int i = 0; i < fileAsString.length(); i++) {
			if (fileAsString.charAt(i) == '\'') {
				String sub1 = fileAsString.substring(0, i);
				String sub2 = fileAsString.substring(i, fileAsString.length());
				fileAsString = sub1 + '\'' + sub2; 
				i++;
			}
		}

		return fileAsString;
	}
	
	//Converts string into a text file.
	public static void writeStringToFile(String content, String filePath) {
		try {
			Files.writeString(Paths.get(filePath), content);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws IOException {
		System.out.println(readFileAsString2("/Users/jgadde/Downloads/Dr.PaulLoser.txt"));
		//readFileAsString2("/Users/jgadde/Downloads/JoelMillner.txt");
		//System.out.println(readFileAsString2("/Users/jgadde/Downloads/JoelMillner.txt"));
		//System.out.println(readFileAsString2("/Users/jgadde/Downloads/Transcript.txt"));
		// String content = readFileAsString("/Users/jgadde/Downloads/Transcript.txt");
		// writeStringToFile(content, "/Users/jgadde/Downloads/Transcript2.txt");
	}

}
