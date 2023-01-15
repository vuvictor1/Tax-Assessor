/********************************************************************************************
; Author Information:                                                                       *
; Name: Victor V. Vu                                                                        *
; Email: vuvictor@csu.fullerton.edu                                                         *
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Tax Assessor                                                                *
; This File: isfloat.c                                                                      *
; Description: Called by get_assessed_values to verify float                                *
;                                                                                           *
; Copyright (C) 2022 Victor V. Vu                                                           *
; This program is free software: you can redistribute it and/or modify it under the terms   *
; of the GNU General Public License version 3 as published by the Free Software Foundation. *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. *
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;                                                                                           *
; Programmed in Ubuntu-based Linux Platform.                                                *
; To run program, type in terminal: "sh r.sh"                                               *
*********************************************************************************************/
#include <ctype.h>
#include <stdio.h>

extern int isfloat(char[]); // Make ispositivefloat visible to functions

int isfloat(char user_input[]) {
  int result = 1; // result is a float
  int decimal_found = 0; // decimal not found
  int current_index = 0; // starting point

  if (user_input[current_index] == '+') // If index start has a + proceed
  {
    ++current_index;
  }

  while (user_input[current_index] != '\0' && result) {
    if ((user_input[current_index] == '.') && !decimal_found) // search for decimal
    {
      decimal_found = 1;
    } else {
      if (isdigit(user_input[current_index]) == 0) {
        result = 0; // return 0 = Not a float
        break;
      }
    }
    ++current_index;
  }
  return (result && decimal_found);
}
