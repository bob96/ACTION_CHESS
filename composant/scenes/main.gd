extends Node2D

#var clicked = false
var piece_selected = false
var piece
var pos_init
#var previous=-1
var first_click=false
var board_pos
onready var board = get_node("board")
onready var pieces = get_node("piece")

func _ready():
	set_process_input(true)
	set_fixed_process(true)
func _process(delta):
	
	pass
func _input(event):
	#selection de la piece a bouger
	if event.is_action_pressed("mouse") and !piece_selected:
		#getting the piece pos
		pos_init = print_pos(pieces)
		#getting the piece tile type
		piece = pieces.get_cellv(pos_init)
		print(piece)
		#getting the board tile type
		board_pos = board.get_cellv(pos_init)
		print(board_pos)
		if piece!=-1:
			piece_selected=true
			
	#mouvement de la piece
	elif event.is_action_pressed("mouse") and piece_selected:
		#getting the pos chosen to move the peice
		var pos_selected=print_pos(board)
		var pos_sel_board=board.get_cellv(pos_selected)
		# si la case est vide
		if(pieces.get_cellv(pos_selected)==-1):
			#mouvements du pion
			if(piece==3):
				pawn_mov(pos_sel_board,board_pos,pos_selected)
			#mouvements du roi
			if(piece==1):
				king_mov(pos_sel_board,board_pos,pos_selected)
			#mouvements de la tour
			if(piece==5):
				rook_mov(pos_sel_board,board_pos,pos_selected)
			#mouvements du cavalier
			if(piece==2):
				knight_mov(pos_sel_board,board_pos,pos_selected)
			#mouvements de la reine
			if(piece==4):
				queen_mov(pos_sel_board, board_pos,pos_selected)
			#mouvements du fou
			if(piece==0):
				bishop_mov(pos_sel_board,board_pos,pos_selected)
		else:
			print("Veuillez choisir une case vide")
			piece_selected=false
			
		
func print_pos(tiles):
	var mouse_pos = get_global_mouse_pos()
	var tile= tiles.world_to_map(mouse_pos)
	return tile

############################################################
############################################################

########################MOUVEMENT PION######################
func pawn_mov(pos_sel_board,board_pos,pos_selected):
	if board_pos>=48 and board_pos<=55:
		if pos_sel_board==board_pos-8 or pos_sel_board==board_pos-16:
			basic_mov(pos_init,pos_selected,piece)
	elif pos_sel_board==board_pos-8:
		basic_mov(pos_init,pos_selected,piece)
	else:
		pos_selected=false
#########################MOUVEMENT CAVALIER###################
func knight_mov(pos_sel_board,board_pos,pos_selected):
	if pos_sel_board==board_pos+15 or pos_sel_board==board_pos+17 or pos_sel_board==board_pos+6 or pos_sel_board==board_pos+10 or pos_sel_board==board_pos-10 or pos_sel_board==board_pos-6 or pos_sel_board==board_pos-15 or pos_sel_board==board_pos-17:
		basic_mov(pos_init,pos_selected,piece)
	else:
		pos_selected=false
##########################MOUVEMENT ROI#######################
func king_mov(pos_sel_board,board_pos,pos_selected):
	if(pos_sel_board==board_pos-8 or pos_sel_board==board_pos+8 or pos_sel_board==board_pos+1 or pos_sel_board==board_pos-1 or pos_sel_board == board_pos+7 or pos_sel_board== board_pos+9 or pos_sel_board==board_pos-7 or pos_sel_board==board_pos-9 ):
		basic_mov(pos_init,pos_selected,piece)
	else:
		pos_selected=false
##########################MOUVEMENTS REINE#####################
func queen_mov(pos_sel_board,board_pos,pos_selected):
	rook_mov(pos_sel_board,board_pos,pos_selected)
	bishop_mov(pos_sel_board,board_pos,pos_selected)
	
##########################MOUVEMENTS FOU####################
func bishop_mov(pos_sel_board,board_pos,pos_selected):
	var can_move=false
	var temp1=board_pos
	var temp2=board_pos
	if temp1 < pos_sel_board:
		while(temp1<pos_sel_board or temp2<pos_sel_board):
			temp1=temp1+7
			temp2=temp2+9
			if temp1==pos_sel_board or temp2==pos_sel_board:
				can_move=true
				break
	elif temp1> pos_sel_board:
		while(temp1>pos_sel_board or temp2>pos_sel_board):
			temp1=temp1-7
			temp2=temp2-9
			if temp1==pos_sel_board or temp2==pos_sel_board:
				can_move=true
				break
	if(can_move):
		#remove the piece from the initial pos
		pieces.set_cellv(pos_init,-1)
		#place the tile in the selected pos 
		pieces.set_cellv(pos_selected,piece)
		piece_selected = false
	else:
		pos_selected=false
##########################MOUVEMENTS TOUR#######################
func rook_mov(pos_sel_board,board_pos,pos_selected):
	var can_move=false
	var temp=pos_sel_board
	
	if temp < board_pos:
		#mouvement possible
		if(board_pos-temp<8):
			can_move=true
		else:
			while(temp<board_pos):
				
				temp=temp+8
				if(temp==board_pos):
					can_move=true
					break
	elif temp > board_pos :
		
		if(temp-board_pos<8):
			can_move=true
		else:
			while temp > board_pos :
				temp=temp-8
				if(temp==board_pos):
					can_move=true
					break
		
	if(can_move):
		#remove the piece from the initial pos
		pieces.set_cellv(pos_init,-1)
		#place the tile in the selected pos 
		pieces.set_cellv(pos_selected,piece)
		piece_selected = false
	else:
		pos_selected=false
########################mouvement diagonal
func diag_check():
	pass
########################mouvement Horizental
func horizental_check():
	pass
########################mouvement vertical
func vertical_check():
	pass
func basic_mov(pos_init,pos_selected,piece):
	#remove the piece from the initial pos
	pieces.set_cellv(pos_init,-1)
	#place the tile in the selected pos 
	pieces.set_cellv(pos_selected,piece)
	piece_selected = false

