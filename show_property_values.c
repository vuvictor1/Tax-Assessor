/********************************************************************************************
; Author Information:                                                                       *
; Name: Victor V. Vu                                                                        *
; Email: vuvictor@csu.fullerton.edu                                                         *
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Tax Assessor                                                                *
; This File: show_property_values                                                           *
; Description: After user input is taken, manager calls for display array.                  *
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

#include <stdio.h>

extern void show_property_values(double array[], long size); // takes in the array and the size

void show_property_values(double array[], long size) {
  printf("\nThank you. Here are the assessed property values in this district:\n\n");

  for (long i = 0; i < size; i++) { // Iterates the array to output every element
    printf("%.2lf\n", array[i]);
  }

  return;
}
