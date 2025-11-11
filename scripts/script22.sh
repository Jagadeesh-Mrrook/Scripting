#!/bin/bash

echo "Select any of the operation to perform"

echo "1 - check if the given input is file or dir"
echo "2 - Perform arithmetic on two numbers"
echo "3 - String operations"
echo "4 - Print all even numbers up to N"
echo "5 - Exit"

read -p "Enter the option (1-5):" option


case $option in 
  1)
    read -p "Enter the path: " path
    if [[ -z $path ]]; then
      echo "Invalid Path"
      exit 1
    else
      if [[ -f $path ]]; then
        echo "$path is a file"
      elif [[ -d $path ]]; then
        echo "$path is a dir"
      elif [[ -e $path ]]; then
        echo "$path exists but its not a file or dir its something else"
      else
        echo "It does not exists"
      fi
    fi
    ;;

  2)
    read -p "Enter two numbers with space seperated:" a b
    if [[ $a =~ ^[+-]?[0-9]+$ ]]; then
      echo "$a is a valid number"
    else
      echo "Enter valid number (0-9)"
      exit 3
    fi
        if [[ $b =~ ^[+-]?[0-9]+$ ]]; then
      echo "$b is a valid number"
    else
      echo "Enter valid number (0-9)"
      exit 4
    fi

    echo "Select an operation to perform"

    echo "1 - add"
    echo "2 - subtract" 
    echo "3 - Multiply"
    echo "4 - Divide"

    read -p "Enter an option" operation

    case $operation in 
      1)
        addition=$(( a + b ))
        echo "Answer: $addition"
        ;;
      2)
        sub=$(( a - b ))
        echo "Answer: $sub"
        ;;
      3)
        mul=$(( a * b ))
        echo "Answer: $mul"
        ;;
      4)
        if [[ $b -eq 0 ]]; then
          echo "Cannot divide $a with 0 enter any other number"
        else
           div=$(( a / b ))
           echo "Answer: $div"
        fi
        ;;
    esac
    ;;

  3)
    read -p "Enter a string:" string
    
    echo "Select an option"

    echo "1 - Convert to UPPERCASE"
    echo "2 - Convert ot lowercase"
    echo "3 - Reverse the string"
    echo "4 - Count numbers of Characters"

    read -p "Select any of the task (0-4):" task

    case $task in 
      1)
        echo "converted to UPPERCASE ${string^^}"
        ;;
      2)
        echo "converted to lowercase ${string,,}"
        ;; 
      3)
        echo "$string" | rev
        ;;
      4)
        echo -n "$string" | wc -c   
        ;;
    esac
    ;;

  4)
    read -p "Enter positive number" number
      if [[ $number =~ ^[0-9]+$ ]] && [[ $number -gt 0 ]]; then
        echo "$number is valid"
        for (( i=2; i<=number; i++ )); do
          if [[ $(( i % 2 )) -eq 0 ]]; then
            echo "Number: $i"
          fi
        done
      else
        echo "Enter valid number"
      fi
     ;;

  5)
    echo "Good Bye"
    exit 2
    ;;
  *)
    echo "Invalid choice"
    ;;
esac
