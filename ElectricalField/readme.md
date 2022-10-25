# Electrical Field Simulation
This matlab script creates a window where the user can manipulate the dimensions and separation of 2 electrically charged bars, as well as add globules with may (or may not) have a significant eletric difference within two points.

- - -
When the application starts, the user will see a window with
- an illustration of two electrically charged bars and their electric field,
- a blank table and a button for adding globules
- a group of sliders for each bar size and the separation between them

Moving the sliders will update the illustration (both bars and their electric field).

The "Add Globules" button will add, one by one, up to 5 globules to the simulation and add their information to the table. Each globule is a sphere which contains two smaller spheres inside of it. Once a globule is added, the bars attributes can no longer be changed through the sliders.

Each globule represents a blood cell which, may or may not, be infected with malaria. Malaria is a disease which can be identified by the difference on electric potencial that a infected cell exhibits, so this script simulates the "infectedness" of a cell by randomizing the distance between the two inner dots of every globule (where electric field is measured), and therefore, the electric potencial difference of said cell.

The table displays the distance between a cell inner dots, its position, the difference in electrical field between said dots and if the cell is infected or not.