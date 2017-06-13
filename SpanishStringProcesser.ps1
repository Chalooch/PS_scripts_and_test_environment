#
# eagleindinc.aaron
#
<#
	This script attempts to manipulate spanish-english words based on a few rules.

#>

Clear-Content $output;
$book = get-content C:\Users\aaron\Desktop\PS_scripts_and_test_environment\SpanishScriptProcess\Coleccion-Incompleta.txt;
$output = "C:\Users\aaron\Desktop\PS_scripts_and_test_environment\SpanishScriptProcess\Complete-Notes.txt";
$word_arr = $book -split "\n"; # {$_ -eq " " -or $_ -eq "-"}
$word = "";
[string[]] $phrases = "";

for ($i = 0; $i -lt $($word_arr.Length - 1); $i += 2) {
	# infinitive case
    if ($word_arr[$i] -match "[aei]r$" -and $word_arr[$i].Split().Length -eq 1) {
		$word_arr[$i] + " -> " + $word_arr[$i+1] | Out-File $output -Append;
    }
	# preterite case (supports accented o and accented e)
	elseif ($word_arr[$i] -match "[\u00D3\u00F3]$" -and $word_arr[$i].Split().Length -eq 1) {
		if ($word_arr[$word_arr[$i].Length - 2] -eq "i" -and $word_arr[$word_arr[$i].Length - 1] -eq "\u00D3") {
			$word = $word_arr[$i].Replace("i\u00D3", "(er,ir)");
		}
		else {
			$word = $word_arr[$i].Remove($word_arr[$i].Length - 1);
			$word += "ar";
		}
		# english preterite ending with "-ed"
		if ($word_arr[$i + 1].EndsWith("ed")) {
			$verb = $word_arr[$i + 1].Remove($word_arr[$i + 1].Length - 2, 2);
			$word + " -> to " + $verb | Out-File $output -Append; 
		} 
		# english irregular preterite (eg. ran -> run) FIXME
		else {
			$word + " -> " + $word_arr[$i+1] | Out-File $output -Append; 
		} 
	}
	# imperfect case (supports first-person and third-person singular plural)
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
		# english preterite ending with "-ed"
		if ($word_arr[$i + 1].EndsWith("ed")) {
			$verb = $word_arr[$i + 1].Remove($word_arr[$i + 1].Length - 2, 2);
			$word + " -> to " + $verb | Out-File $output -Append; 
		} 
		# english irregular preterite (eg. ran -> run) FIXME
		else {
			$word + " -> " + $word_arr[$i+1] | Out-File $output -Append; 
		}
    }
	# noun case ((in)definite article optional)
	elseif ($word_arr[$i].Split().Length -eq 1 -or $word_arr[$i].Split().Length -eq 2) {
		$word_arr[$i] + " -> " + $word_arr[$i+1] | Out-File $output -Append;
	}
    elseif ($word_arr[$i].Split().Length -gt 2) {
		$phrases += $word_arr[$i] + "`n";
    }
}

# Write the phrases on a separate line
for ($i = 0; $i -lt $($phrases.Length - 1); $i++) {
	$phrases[$i] | Out-File $output -Append;
}