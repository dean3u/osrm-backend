@routing @bicycle @restrictions
Feature: Bike - Turn restrictions
	Handle turn restrictions as defined by http://wiki.openstreetmap.org/wiki/Relation:restriction
	Note that if u-turns are allowed, turn restrictions can lead to suprising, but correct, routes.
	
	Background: Use car routing
		Given the profile "bicycle"
	
	@no_turning
	Scenario: Bike - No left turn
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction  |
		 | restriction | sj       | wj     | j        | no_left_turn |

		When I route I should get
		 | from | to | route |
		 | s    | w  |       |
		 | s    | n  | sj,nj |
		 | s    | e  | sj,ej |

	@no_turning
	Scenario: Bike - No right turn
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction   |
		 | restriction | sj       | ej     | j        | no_right_turn |

		When I route I should get
		 | from | to | route |
		 | s    | w  | sj,wj |
		 | s    | n  | sj,nj |
		 | s    | e  |       |

	@no_turning
	Scenario: Bike - No u-turn
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction |
		 | restriction | sj       | wj     | j        | no_u_turn   |

		When I route I should get
		 | from | to | route |
		 | s    | w  |       |
		 | s    | n  | sj,nj |
		 | s    | e  | sj,ej |

	@no_turning
	Scenario: Bike - Handle any no_* relation
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction      |
		 | restriction | sj       | wj     | j        | no_weird_zigzags |

		When I route I should get
		 | from | to | route |
		 | s    | w  |       |
		 | s    | n  | sj,nj |
		 | s    | e  | sj,ej |

	@only_turning
	Scenario: Bike - Only left turn
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction    |
		 | restriction | sj       | wj     | j        | only_left_turn |

		When I route I should get
		 | from | to | route |
		 | s    | w  | sj,wj |
		 | s    | n  |       |
		 | s    | e  |       |

	@only_turning
	Scenario: Bike - Only right turn
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction     |
		 | restriction | sj       | ej     | j        | only_right_turn |

		When I route I should get
		 | from | to | route |
		 | s    | w  |       |
		 | s    | n  |       |
		 | s    | e  | sj,ej |
	
	@only_turning
	Scenario: Bike - Only straight on
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction      |
		 | restriction | sj       | nj     | j        | only_straight_on |

		When I route I should get
		 | from | to | route |
		 | s    | w  |       |
		 | s    | n  | sj,nj |
		 | s    | e  |       |

	@no_turning
	Scenario: Bike - Handle any only_* restriction
		Given the node map
		 |   | n |   |
		 | w | j | e |
		 |   | s |   |

		And the ways
		 | nodes | oneway |
		 | sj    | yes    |
		 | nj    | -1     |
		 | wj    | -1     |
		 | ej    | -1     |

		And the relations
		 | type        | way:from | way:to | node:via | restriction        |
		 | restriction | sj       | nj     | j        | only_weird_zigzags |

		When I route I should get
		 | from | to | route |
		 | s    | w  |       |
		 | s    | n  | sj,nj |
		 | s    | e  |       |

 	@except
 	Scenario: Bike - Except tag and on no_ restrictions
 		Given the node map
 		 | b | x | c |
 		 | a | j | d |
 		 |   | s |   |

 		And the ways
 		 | nodes | oneway |
 		 | sj    | no     |
 		 | xj    | -1     |
 		 | aj    | -1     |
 		 | bj    | no     |
 		 | cj    | -1     |
 		 | dj    | -1     |

 		And the relations
 		 | type        | way:from | way:to | node:via | restriction   | except  |
 		 | restriction | sj       | aj     | j        | no_left_turn  | bicycle |
 		 | restriction | sj       | bj     | j        | no_left_turn  |         |
 		 | restriction | sj       | cj     | j        | no_right_turn |         |
 		 | restriction | sj       | dj     | j        | no_right_turn | bicycle |

 		When I route I should get
 		 | from | to | route |
 		 | s    | a  | sj,aj |
 		 | s    | b  |       |
 		 | s    | c  |       |
 		 | s    | d  | sj,dj |

  	@except
  	Scenario: Bike - Except tag and on only_ restrictions
  		Given the node map
  		 | a |   | b |
  		 |   | j |   |
  		 |   | s |   |

  		And the ways
  		 | nodes | oneway |
  		 | sj    | yes    |
  		 | aj    | no     |
  		 | bj    | no     |

  		And the relations
  		 | type        | way:from | way:to | node:via | restriction      | except  |
  		 | restriction | sj       | aj     | j        | only_straight_on | bicycle |

  		When I route I should get
  		 | from | to | route |
  		 | s    | a  | sj,aj |
  		 | s    | b  | sj,bj |

  	@except
  	Scenario: Bike - Multiple except tag values
  		Given the node map
  		 | s | j | a |
  		 |   |   | b |
  		 |   |   | c |
  		 |   |   | d |
  		 |   |   | e |
  		 |   |   | f |

  		And the ways
  		 | nodes | oneway |
  		 | sj    | yes    |
  		 | ja    | yes    |
  		 | jb    | yes    |
  		 | jc    | yes    |
  		 | jd    | yes    |
  		 | je    | yes    |
  		 | jf    | yes    |

  		And the relations
  		 | type        | way:from | way:to | node:via | restriction    | except           |
  		 | restriction | sj       | ja     | j        | no_straight_on |                  |
  		 | restriction | sj       | jb     | j        | no_straight_on | bicycle          |
  		 | restriction | sj       | jc     | j        | no_straight_on | bus; bicycle     |
  		 | restriction | sj       | jd     | j        | no_straight_on | bicycle; motocar |
  		 | restriction | sj       | je     | j        | no_straight_on | bus, bicycle     |
  		 | restriction | sj       | jf     | j        | no_straight_on | bicycle, bus     |

  		When I route I should get
  		 | from | to | route |
  		 | s    | a  |       |
  		 | s    | b  | sj,jb |
  		 | s    | c  | sj,jc |
  		 | s    | d  | sj,jd |
  		 | s    | e  |       |
  		 | s    | f  |       |
