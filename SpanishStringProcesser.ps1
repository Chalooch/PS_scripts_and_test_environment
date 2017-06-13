#
# eagleindinc.aaron
#

Clear-Content C:\Users\Aaron\Desktop\Complete-Notes.txt
$book = get-content C:\Users\Aaron\Desktop\Coleción-Incompleta.txt;
$word_arr = $book -split "\n" # {$_ -eq " " -or $_ -eq "-"}
[string[]] $phrases 

for ($i = 0; $i -lt $($word_arr.Length - 1); $i += 2) {
    if ($word_arr[$i] -match "[aei]r$" -and $word_arr[$i].Split().Length -eq 1) {
		$word_arr[$i] + " -> " + $word_arr[$i+1] | Out-File C:\Users\Aaron\Desktop\Complete-Notes.txt -Append;
    }
    elseif ($word_arr[$i] -match "[ab,í]an?$" -and $word_arr[$i].Split().Length -eq 1) {
		if ($word_arr[$i].EndsWith("aba")) {
			$word = $word_arr[$i].Replace("aba", "ar");
		}
		elseif ($word_arr[$i].EndsWith("aban")) {
			$word = $word_arr[$i].Replace("aban", "ar");
		}
		else {
			if ($word_arr[$i].EndsWith("n")) {
				$word = $word_arr[$i].Replace("ían", "(er,ir)");
			}
			else {
				$word = $word_arr[$i].Replace("ía", "(er,ir)");
			}
		}
		if ($word_arr[$i + 1].EndsWith("ed")) {
			$verb = $word_arr[$i + 1].Remove($word_arr[$i + 1].Length - 2, 2);
			$word + " -> to " + $verb | Out-File C:\Users\Aaron\Desktop\Complete-Notes.txt -Append; 
		} 
		else {
			$word + " -> " + $word_arr[$i+1] | Out-File C:\Users\Aaron\Desktop\Complete-Notes.txt -Append; 
		}
    }
	elseif ($word_arr[$i].Split().Length -eq 2) {
		$word_arr[$i] + " -> " + $word_arr[$i+1] | Out-File C:\Users\Aaron\Desktop\Complete-Notes.txt -Append; 
	}
    elseif ($word_arr[$i].Split().Length -gt 2) {
		$phrases += $word_arr[$i];
    }
}