
local cfg = {}

-- paycheck and bill for users
cfg.message_paycheck = "You received your salary: ~g~$" -- message that will show before payment of salary
cfg.message_bill = "You paid: ~r~$" -- message that will show before payment of bill
cfg.post = "." -- message that will show after payment

cfg.bank = true -- if true money goes to bank, false goes to wallet

cfg.minutes_paycheck = 10 -- minutes between payment for paycheck
cfg.minutes_bill = 30 -- minutes between withdrawal for bill

cfg.paycheck_title_picture = "Maze Bank" -- define title for paycheck notification picture
cfg.paycheck_picture = "CHAR_BANK_MAZE" -- define paycheck notification picture want's to display
cfg.bill_title_picture = "Mors Mutual" -- define title for bill notification picture
cfg.bill_picture = "CHAR_MP_MORS_MUTUAL" -- define bill notification picture want's to display

cfg.paycheck = { -- ["permission"] = paycheck
  ["police.paycheck"] = 3000,
  ["emergency.paycheck"] = 3000,
  ["taxi.paycheck"] = 1000,
  ["repair.paycheck"] = 1000,
  ["delivery.paycheck"] = 1000
}

cfg.bill = { -- ["permission"] = withdrawal
  ["police.paycheck"] = 100,
  ["emergency.paycheck"] = 100,
  ["taxi.paycheck"] = 100,
  ["repair.paycheck"] = 100,
  ["delivery.paycheck"] = 100
}

return cfg
