# Read("C:/Users/Gavin/Desktop/GAP Code/Kevin Subgroups Stuff/PossibleSubAfterSome.g");

RInd:=[ 323, 351, 353, 367, 368, 373, 374, 380, 381, 408, 409, 434, 436, 440, 449, 501, 514, 532, 536, 5421, 5427, 5430, 6532, 6533, 6620, 6629, 6642, 6647, 6648, 6674, 6693, 6700, 6701, 6704, 6709, 6711, 6716, 6717, 6720, 23224, 23225 ]; 
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

output := OutputTextFile( "C:/Users/Gavin/Desktop/GAP Code/Kevin Subgroups Stuff/PotentialSubsSecondPass.txt", false );

for i in SubInd do
    AppendTo(output, i, "\n");
od;

CloseStream(output);