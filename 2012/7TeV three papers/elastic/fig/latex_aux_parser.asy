struct LatexReference {
	string type, label, ref;
};

LatexReference latexReferences[];

//----------------------------------------------------------------------------------------------------

int ParseAuxFile(string filename)
{
	file f = input(filename, false);
	if (error(f))
		return 1;

	while (!eof(f)) {
		string line = f;
		string[] bits = split(line, "{");
		
		if (bits[0] == "\newlabel") {
			LatexReference r;
			r.type = "label";
			r.label = replace(bits[1], "}", "");

			string bbits[] = split(replace(bits[2], "}", ""), "{");
			r.ref = replace(bbits[0], "}", "");
			latexReferences.push(r);
		}

		if (bits[0] == "\bibcite") {
			LatexReference r;
			r.type = "bibcite";
			r.label = replace(bits[1], "}", "");
			r.ref = replace(bits[2], "}", "");
			latexReferences.push(r);
		}
	}

	write(format("ParseAuxFile > %i references loaded", latexReferences.length));

	return 0;
}

//----------------------------------------------------------------------------------------------------

string GetLatexReference(string type, string label)
{
	for (int ri : latexReferences.keys) {
		if (latexReferences[ri].type == type && latexReferences[ri].label == label)
			return latexReferences[ri].ref;
	}

	return "??";
}
