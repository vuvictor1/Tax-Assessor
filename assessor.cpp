/********************************************************************************************
; Author Information:                                                                       *
; Name: Victor V. Vu                                                                        *
; Email: vuvictor@csu.fullerton.edu                                                         *
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Tax Assessor                                                                *
; This File: assessor.cpp                                                                   *
; Description: Output time, text, and calls on manager.asm                                  *
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
// Required headers
#include <cstdio>
#include <iomanip>
#include <iostream>
#include <string.h>
#include <time.h>

// External functions included
extern "C" double tax();       
extern "C" double get_value(); 

#define BUF_LEN 256

int main() {
  std::cout << "\nWelcome to the Orange County Property Assessment Office on ";

  // Time updater
  char size[BUF_LEN] = {0};
  time_t current_time = time(NULL);
  struct tm *ptm = localtime(&current_time);
  memset(size, 0, BUF_LEN);
  strftime(size, BUF_LEN, "%B %-d, %G", ptm);
  puts(size);
  // -----------

  std::cout << "For assistance contact Victor Vu at vuvictor@premier.com" << std::endl;

  double value = tax(); // Data is being returned from the assembly file

  std::cout << std::endl;

  if (value != -1) { // Check if float has been verified
    std::cout << "\nThe Assessor’s Office received this number " << std::fixed
              << std::setprecision(2) << value << " and will simply keep it. ";
  } else {
    std::cout << "The main driver received this number 0.0 and will simply keep it. " << std::endl;
  }

  std::cout << std::endl;
  std::cout << "Next an integer 0 will be sent to the operating system as a signal of successful completion."
            << std::endl;

  return 0;
}
