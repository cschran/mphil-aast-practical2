# use with VMD like this:
# vmd -e view-PIMD-water.tcl -args <first> <last> <step> system-centroid.xyz system-???.xyz
#
# customize representations to taste

set material AOChalky
color Display Background white
axes location Off
display depthcue off
display shadows on
display ambientocclusion on
display aoambient 1.000000
display aodirect 0.400000
color change rgb 6 0.750000 0.750000 0.750000
color change rgb 2 0.150000 0.150000 0.150000

# load centroid positions
mol new [lindex $argv 3] waitfor all first [lindex $argv 0] last [lindex $argv 1] step [lindex $argv 2]
mol delrep 0 top
pbc set {13.489   15.576   14.641} -all
pbc wrap -compound res -all
pbc box  -color black -width 1

# create centroid representation
#mol representation CPK 0.4 0.0 10.0 10.0
mol representation CPK 0.8 0.0 10.0 10.0
mol color Name
mol selection {all}
mol material $material
mol addrep top
#mol representation DynamicBonds 1.4 0.1 10.0
mol representation DynamicBonds 1.4 0.2 10.0
mol color Name
mol selection {all}
mol material $material
mol addrep top

# hydrogen bonds
mol representation HBonds 3.0 20.0 0.5
mol selection {all}
mol material $material
mol color ColorID 6
mol addrep top

# process all replicas
foreach filename [lrange $argv 4 $argc-1] {

    # load replica coordinates
    mol new $filename waitfor all first [lindex $argv 0] last [lindex $argv 1] step [lindex $argv 2]
    mol delrep 0 top
    pbc set {13.489   15.576   14.641} -all
    pbc wrap -compound res -all

    # create replica representation
    mol representation CPK 0.8 0.0 10.0 10.0
    #mol representation CPK 0.2 0.0 10.0 10.0
    mol color Name
    mol selection {all}
    mol material $material
    mol addrep top
}

color Name H silver 
color Name F iceblue
color Name C gray
