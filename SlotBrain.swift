//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by mircea on 1/2/15.
//  Copyright (c) 2015 mltru. All rights reserved.
//

import Foundation

class SlotBrain {
    
    class func unpackSlotsIntoSlotRows(slots: [[Slot]]) -> [[Slot]] {
        var slotRow: [Slot] = []
        var slotRow2: [Slot] = []
        var slotRow3: [Slot] = []
        var index:Int = 0
        
        for slotArray in slots {
            for index = 0; index < slotArray.count; index++ {
                let slot = slotArray[index]
                
                switch index {
                    case 0: slotRow.append(slot)
                    case 1: slotRow2.append(slot)
                    case 2: slotRow3.append(slot)
                    default:
                        println("Error")
                }
            }
        }
        
        var result: [[Slot]] = [slotRow, slotRow2, slotRow3]
        return result
    }
    
    class func computeWinnings(slots: [[Slot]]) -> Int {
        var slotsInRows = unpackSlotsIntoSlotRows(slots)
        var winnings = 0
        
        var flushWinCount = 0
        var threeOfAKindCount = 0
        var straightWinCount = 0
        
        for slotRow in slotsInRows {
            if (checkForFlush(slotRow)) {
                println("Flush");
                winnings += 1
                flushWinCount += 1
            }
            if (checkForSameKind(slotRow)) {
                println("Three of a kind")
                winnings += 3
                threeOfAKindCount += 1
            }
            if (checkForStraight(slotRow)) {
                println("Straight")
                winnings += 1
                straightWinCount += 1
            }
        }
        
        if (flushWinCount==3) {
            println("Royal flush")
            winnings += 15
        }
        if (threeOfAKindCount == 3) {
            println("Threes all over")
            winnings += 50
        }
        if (straightWinCount==3) {
            println("Epic straight")
            winnings += 1000
        }
        
        return winnings
    }
    
    class func checkForFlush(slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        return slot1.isRed == slot2.isRed && slot1.isRed == slot3.isRed
    }
    
    class func checkForSameKind(slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        return slot1.value == slot2.value && slot1.value == slot3.value
    }
    
    class func checkForStraight(slotRow: [Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if (slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2) {
            return true
        }
        if (slot1.value == slot2.value - 1 && slot1.value == slot3.value - 2) {
            return true
        }
        return false
    }
    
}