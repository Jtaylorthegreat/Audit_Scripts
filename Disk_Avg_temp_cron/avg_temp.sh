#!/bin/bash

INPUTFILE=
        
column_1_avg () {
        count=0;
        total=0;

        for i in $( awk ' {print $1; }' $INPUTFILE )
                do
                        total=$(echo $total+$i | bc )
                        ((count++))
                done
        echo "scale=2; $total / $count" | bc 
}

column_2_avg () {
        count=0;
        total=0;

        for i in $( awk ' {print $2; }' $INPUTFILE )
                do
                        total=$(echo $total+$i | bc )
                        ((count++))
                done
        echo "scale=2; $total / $count" | bc
}


echo "Drive 1 average overall temp:"
column_1_avg
echo "Drive 2 average overall temp:"
column_2_avg
