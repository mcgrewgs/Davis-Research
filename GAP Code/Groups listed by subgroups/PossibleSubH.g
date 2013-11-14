# Read("C:/GAP/FPDR13/PossibleSubH.g");

RInd:=[323, 351, 353, 367, 368, 369, 370, 372, 373, 374, 375, 376, 379, 380, 381, 408, 409, 433, 434, 435, 436, 437, 439, 440, 442, 449, 450, 452, 501, 509, 514, 522, 532, 536, 5331, 5421, 5422, 5423, 5427, 5430, 6532, 6533, 6620, 6629, 6631, 6639, 6641, 6642, 6647, 6648, 6674, 6676, 6678, 6693, 6696, 6700, 6701, 6704, 6709, 6711, 6712, 6714, 6715, 6716, 6717, 6718, 6720, 6721, 23224, 23225]; 
PSubs:=[];
SubInd:=[];
SubPerRInd:=[];

for i in RInd do
	G:=SmallGroup(256,i);
	Hs:=NormalSubgroups(G);
	Print("Analyzing Subgroups of Group Index: ",i,"\n");
	si:=[];
	for j in Hs do
		if (Size(j)=16 or Size(j)=32 or Size(j)=64) then
			Add(PSubs, IdSmallGroup(j));
			Add(si,IdSmallGroup(j));
		fi;
	od;
	Add(SubPerRInd,si);
od;

PSubs:=AsSSortedList(PSubs);
Print(Length(PSubs),"\n");

for j in PSubs do
	H:=SmallGroup(j[1],j[2]);

	ll:=[j,",",StructureDescription(H),":"];
	Print("Pairing with Subgroup: ",IdSmallGroup(H),"\n");
	for i in [1..Length(RInd)] do
		G:=SmallGroup(256,RInd[i]);
		if (j in SubPerRInd[i]) then
		Add(ll,IdSmallGroup(G)[2]);
		fi;
	od;
	if not(Length(ll)=1) then
	Add(SubInd,ll);
	fi;
od;

Print(SubInd);

output := OutputTextFile( "C:/GAP/FPDR13/PotentialSubsForConst.txt", false );

for i in SubInd do
    AppendTo(output, i, "\n");
od;

CloseStream(output);