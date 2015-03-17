--[[
local myButton = MyButton.new({normal="img/star.png"},self,function()
--do something
end)
--]]


local MyButton = class("MyButton")
function MyButton:ctor(params,scene,listener)
    self.button = nil
    local time = 0.1
    local offset = 40
    self.button = cc.ui.UIPushButton.new(params)
        :onButtonClicked(function()
            local spawn1 = cc.Spawn:create({
                cc.MoveBy:create(time,cc.p(0,-offset)),
                cc.ScaleTo:create(time,1,0.3),
            })

            transition.execute(self.button,spawn1,{
                onComplete = function()
                    local spawn2 = cc.Spawn:create({
                        cc.MoveBy:create(time,cc.p(0,offset)),
                        cc.ScaleTo:create(time,1,1)
                    })
                    transition.execute(self.button,spawn2,{
                        easing = "backOut",
                        onComplete = listener
                    })    
                end
            })
        end)
        :center()
        :addTo(scene)
    return self.button
end
return MyButton