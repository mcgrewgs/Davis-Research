# Read( "C:/Users/Gavin/Desktop/GAP Code/TurynBound.g" );

t0 := Runtime()/1000.0;

indices := [1,316,317,318,319,320,321,322,323,324,325,350,351,352,353,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,406,407,408,409,410,411,412,413,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,497,498,499,500,501,502,525,526,527,528,529,530,531,532,533,534,535,536,537,538,539,540,541,6534,6535,6536,6537,6538,6539,6540,6541,6542,6543,6544,6545,6546,6601,6602,6603,6604,6605,6606,6607,6608,6609,6610,6611,6612,6613,6614,6615,6616,6617,6618,6619,6620,6621,6622,6623,6624,6625,6626,6627,6628,6629,6630,6631,6632,6633,6634,6635,6636,6637,6638,6639,6640,6641,6642,6643,6644,6645,6646,6647,6648,6649,6650,6651,6652,6653,6654,6655,6656,6657,6658,6659,6660,6673,6674,6675,6676,6677,6678,6679,6680,6681,6682,6683,6684,6685,6686,6687,6688,6689,6690,6691,6692,6693,6694,6695,6696,6697,6698,6699,6700,6701,6702,6703,6704,6705,6706,6707,6708,6709,6710,6711,6712,6713,6714,6715,6716,6717,6718,6719,6720,6721,6722,6723,6724,6725,6726,6727,6728,6729,6730,6731,26959,26960,26961,26962,26963,26964,26965,26966,26967,26968,26969,26970,26971,26972];

noDS := [];

c64 := CyclicGroup(64);
c128 := CyclicGroup(128);
d64 := DihedralGroup(64);
d128 := DihedralGroup(128);

k := 1;
p := Size(indices);

for i in indices do
    Print("Working on group number ", k, " out of ", p ,".  Time taken: ", (Runtime()/1000.0-t0), " seconds.\n");
    k := k+1;
    G := SmallGroup(256,i);
    if not ( Size(GQuotients(G,c64 : findall := false)) = 0 ) then
        Add(noDS, i);
        continue;
    fi;
    if not ( Size(GQuotients(G,c128 : findall := false)) = 0 ) then
        Add(noDS, i);
        continue;
    fi;
    if not ( Size(GQuotients(G,d64 : findall := false)) = 0 ) then
        Add(noDS, i);
        continue;
    fi;
    if not ( Size(GQuotients(G,d128 : findall := false)) = 0 ) then
        Add(noDS, i);
        continue;
    fi;
od;

Print(Size(noDS), " groups have no DS due to the Turyn or Dihedral bound.  They are at these indices: \n");
# Print(noDS);
Print("\n");
Print("Time taken: ", (Runtime()/1000.0-t0), " seconds.\n");

output := OutputTextFile( "C:/Users/Gavin/Desktop/GAP Code/TurynBound.txt", false );

for i in noDS do
    AppendTo(output, i, "\n");
od;

CloseStream(output);