class_name PlayerStats
extends Node2D

const MIN_COINS : int = 0
const DEFAULT_ATTACK : int = 10

@export var _max_life : int = 500 : get = _get_max_life
@export var _life : float = _max_life : get = _get_life 
@export var _coins : int = MIN_COINS : get = _get_coins
@export var _attack : int = DEFAULT_ATTACK : get = _get_attack

func _init():
	super()
	self._life = _max_life
	self._coins = MIN_COINS


# Add coins to player wallet
func add_coins(coins : int = 1):
	self._coins += coins


# Heal the player 
func heal(life : float = 1):
	
	if self._life + life > _max_life:
		return
		
	self._life += life


# Damage the player
func damage(life : float = 1):
	
	if self._life - life < 0:
		return
	
	self._life -= life


func _get_life() -> float : 
	return _life


func _get_coins() -> int :
	return _coins


func _get_max_life() -> int :
	return _max_life


func _get_attack() -> int : 
	return _attack 
