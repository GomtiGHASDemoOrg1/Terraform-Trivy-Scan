package trivy

import data.lib.trivy

default ignore = false

ignore {
	input.CweIDs[_] == "CWE-787"
}