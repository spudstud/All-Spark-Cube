
class RowObject
{

  // Create a new array of Leds for just this row (16 long)
  LedObject[] anArrayOfRowLeds;

  int rowCoordinateY;
  int rowCoordinateZ;
  
  RowObject(int rowCoordinateY, int rowCoordinateZ)
  {
          // Create a new array of Leds for just this row (16 long)
          this.anArrayOfRowLeds = new LedObject[xNumberOfLedsPerRow];
      
          this.rowCoordinateY = rowCoordinateY;
          this.rowCoordinateZ = rowCoordinateZ;
      
          int firstLedInRow = relativeLedLocationToAbsolute(this.rowCoordinateY, this.rowCoordinateZ);  

	 // Create the led objects, add the lds to the array list, add the array list to the object
         for ( int ledNumberInRowCounter = 0; ledNumberInRowCounter < xNumberOfLedsPerRow; ledNumberInRowCounter++)
	   {
                  // Create led object ( (0-16), #969696=grey, 0 = brightness, ledsize=10)
                  LedObject aLedObject = new LedObject( (firstLedInRow + ledNumberInRowCounter), #969696, 0, ledSize);
  
                  //Add the object to the class array.
                  this.anArrayOfRowLeds[ledNumberInRowCounter] = aLedObject;
                   
                  // Convert this led to an absolute location
                  int ledAbsoluteValue = relativeLedLocationToAbsolute( this.rowCoordinateY, this.rowCoordinateZ ) + ledNumberInRowCounter;  
  	   
                  // Add the led object to the master array aswell 	   
                  //aMasterArrayOfAllLeds[ ledAbsoluteValue ] = aLedObject; 
                  //***NOTE***COMMENTED THIS OUT FOR THIS SANDBOX aMasterArrayOfAllLedsInAllCubes.add(aLedObject);
                     
                  //Decomission the object to mark it for the java garbage collector
                  aLedObject = null;
            }//end for loop create objects

      

  } //end RowObject constuctor


    public void displayOneRow()
    {

          /*The ledInRowCounter is converted from the row[0,0] to a location in the array eg. 48, 64, 256...
           ledInRowCounter is 16 digits larger 63, 95, 255 */
          for ( int ledInRowCounter = 0; ledInRowCounter < xNumberOfLedsPerRow; ledInRowCounter++ )
            {
      
                //  debug("Drawing led " + ledInRowCounter + " out of " + lastLedInRow);
                /*
                        Tips, avoid doing calulations with pixels as long as possible, instead use ratios. 
                 Formula for locating position from left to right
                 1. Get the number of divisions per screen.  16 panels of 16 leds / 2  -1 = 127 leds per screen width
                 2. Get the start location by multiplying the Z panel number ([0-15) by 16 to get the starting row z0 starts at 0, z1 starts at 16, z15 starts at 112
                 3. Shift all leds over 1/2 width to be inbetween lines instead of on top of them + (ledSize / 2)  
                 4. 
                 */

                        // /*127*/   int numberOfDivisionsPerScreen  = zNumberOfPanels * xNumberOfLedsPerRow /2 -1;//  debug("divisions per screen " + numberOfDivisionsPerScreen);
                        // /*13*/    int pixelsBetweenDivisions      = width / numberOfDivisionsPerScreen;//  debug("pixelsBetweenDivisons " + pixelsBetweenDivisions);
                        // /*48*/    int horizontalLedStartLocation  = this.rowCoordinateZ * xNumberOfLedsPerRow * pixelsBetweenDivisions;  //  debug("horizontalStartLocation " + horizontalLedStartLocation); 
                        // /*5px*/   int putLedsBetweenLines         = pixelsBetweenDivisions / 2; //  debug("ledSize " + ledSize /2);
                        //           int formulaResultOfFirstLine    = (putLedsBetweenLines + (horizontalLedStartLocation + (ledInRowCounter * pixelsBetweenDivisions)));              

                        //           int    verticalBuffer              = (height / 2) - (pixelsBetweenDivisions * yNumberOfRowsPerPanel);
                        //           int    verticalStartLocation       = ((height / 2) - verticalBuffer - (pixelsBetweenDivisions / 2));  
                        //           int    verticalRowStartLocation    = (verticalStartLocation - (pixelsBetweenDivisions * this.rowCoordinateY));   


                      //If panel is less than half of all panels draw on upper row, otherwise draw on bottom row
                      if ( this.rowCoordinateZ < ( zNumberOfPanelsPerCube / 2 )  )
                      {	
                        

                        /*127*/   int numberOfDivisionsPerScreen  = zNumberOfPanelsPerCube * ( xNumberOfLedsPerRow /2 ) -1;//  debug("divisions per screen " + numberOfDivisionsPerScreen);
                        /*13*/    int pixelsBetweenDivisions      = width / numberOfDivisionsPerScreen;//  debug("pixelsBetweenDivisons " + pixelsBetweenDivisions);
                        /*48*/    int horizontalLedStartLocation  = this.rowCoordinateZ * xNumberOfLedsPerRow * pixelsBetweenDivisions;  //  debug("horizontalStartLocation " + horizontalLedStartLocation); 
                        /*5px*/   int putLedsBetweenLines         = pixelsBetweenDivisions / 2; //  debug("ledSize " + ledSize /2);
                                  int formulaResultOfFirstLine    = (putLedsBetweenLines + ( horizontalLedStartLocation + ( ledInRowCounter * pixelsBetweenDivisions )  )  );              

                                                                         
                                  int verticalBuffer              = ( (height / 2) - (pixelsBetweenDivisions * yNumberOfRowsPerPanel)  ) /2; //debug("verticalBuffer " + verticalBuffer);
                                  //int verticalBuffer                =    width /  (xNumberOfLedsPerRow * (zNumberOfPanels/2));
                                  int verticalStartLocation       = ( (height / 2) - verticalBuffer - (pixelsBetweenDivisions / 2)   ); // debug("height /2  - vertBuff -pix Per division /2" + ((height / 2) - verticalBuffer - (pixelsBetweenDivisions / 2) ));
                                  int verticalRowStartLocation    = (verticalStartLocation - ( pixelsBetweenDivisions * this.rowCoordinateY )  ); // debug("verticalRowStartLocation " + verticalRowStartLocation + " verticalStartLocation" +verticalStartLocation); 
                                  
                          
                          this.anArrayOfRowLeds[ledInRowCounter].setLedXPixelLocation(formulaResultOfFirstLine); // Set the real location of led on screen in pixels, used with the mouse listener to change when clicked
                          this.anArrayOfRowLeds[ledInRowCounter].setLedYPixelLocation(verticalRowStartLocation); 
                          this.anArrayOfRowLeds[ledInRowCounter].displayOneLed();  // this no longer needs arguments since the x an y in pixels are stored in the object. 

                      }
                      else // draw lower division of panels
                      {

                        /*127*/   int numberOfDivisionsPerScreen  = zNumberOfPanelsPerCube * (xNumberOfLedsPerRow / 2) -1;//  debug("divisions per screen " + numberOfDivisionsPerScreen);
                        /*13*/    int pixelsBetweenDivisions      = width / numberOfDivisionsPerScreen;//  debug("pixelsBetweenDivisons " + pixelsBetweenDivisions);
                        /*48*/    int horizontalLedStartLocation  = (this.rowCoordinateZ * xNumberOfLedsPerRow * pixelsBetweenDivisions) - (numberOfDivisionsPerScreen * pixelsBetweenDivisions) - pixelsBetweenDivisions ;  //  debug("horizontalStartLocation " + horizontalLedStartLocation); 
                        /*5px*/   int putLedsBetweenLines         = pixelsBetweenDivisions / 2; //  debug("ledSize " + ledSize /2);
                                  int formulaResultOfBottomLine   = (putLedsBetweenLines + (horizontalLedStartLocation + (ledInRowCounter * pixelsBetweenDivisions) )   );              

                                  int verticalBuffer              = ( (height /2 ) - (pixelsBetweenDivisions * yNumberOfRowsPerPanel)  )/ 2;
                                  int verticalStartLocation       = ( (height ) - verticalBuffer - (pixelsBetweenDivisions / 2)  );  
                                  int verticalRowStartLocation    = ( verticalStartLocation - (pixelsBetweenDivisions * this.rowCoordinateY)  );   

                          this.anArrayOfRowLeds[ledInRowCounter].setLedXPixelLocation( formulaResultOfBottomLine ); // Set the real location of led on screen in pixels, used with the mouse listener to change when clicked
                          this.anArrayOfRowLeds[ledInRowCounter].setLedYPixelLocation( verticalRowStartLocation ); // Set the abso
                          this.anArrayOfRowLeds[ledInRowCounter].displayOneLed();  // this no longer needs arguments since the x an y in pixels are stored in the object. 

                      }		

   
              }//end for loop
          
    }// end displayOneRow


    int absoluteLedLocationToRelativeY(int absoluteLocation)
    {
        //If the user passes in a number like 48 return the 3 from the 
        //relative location [3, 0] (row 3, panel 0 )
        return absoluteLocation / xNumberOfLedsPerRow;
    }
  
    int absoluteLedLocationToRelativeZ(int absoluteLocation)
    {
          // If the user passes in a number like 48 return the 0 from the 
          // relative location [3,0] (row 3, panel 0 )
          return absoluteLocation / xNumberOfLedsPerRow / yNumberOfRowsPerPanel;
    }
  
  
    int relativeLedLocationToAbsolute(int rowCoordinateY, int rowCoordinateZ )
    {
          //If the user passes in a number like [3,0] (row 3, panel 0) it returns 48. 
          return ( 1 + rowCoordinateY + rowCoordinateZ * zNumberOfPanelsPerCube ) * yNumberOfRowsPerPanel - xNumberOfLedsPerRow;
  		
    }//end relativeLedLocationToAbsolute
    

    int absoluteLocationToPositionInRow(int absoluteLocation)
    {
        // Passing in the absolute location such as 4095 returns the position in the 
        // row 0 - 16.  4095 returns 15, 20 returns 4
        int ledTotalRowNumber = (absoluteLocation / xNumberOfLedsPerRow); // 48 would return 3rd row TODO:Consider renaming locationInY
        int ledPanelNumber = (absoluteLocation / xNumberOfLedsPerRow / yNumberOfRowsPerPanel); //4095 would return panel 15, 300 returns panel 1 TODO:Consider renaming to locationINZ 
        int ledVerticalRowNumber = (ledTotalRowNumber - (yNumberOfRowsPerPanel * ledPanelNumber)); //we need to know how high from the ground, not how many rows there are total
        int firstLedInRow = ((1 + ledVerticalRowNumber + ledPanelNumber * zNumberOfPanelsPerCube ) * yNumberOfRowsPerPanel - xNumberOfLedsPerRow);
    // debug("Led number " + absoluteLocation + " is in position " + (absoluteLocation - firstLedInRow) + " in a row");
    return (absoluteLocation - firstLedInRow);

    }


    /* Pass the led object to the parent
       This allows the Cube to ask the Panel to ask the Row 
       for an exact led object
     */
    LedObject getLedObjectForParent(int ledToFind)
    {
      // Take ledToFind as the absolute location in cube and
      // convert it to the led in the row


      // take the led in the row and return the object from anArrayOfRowLeds
      return anArrayOfRowLeds[absoluteLocationToPositionInRow(ledToFind)];
    }

    
} // end class RowObject

