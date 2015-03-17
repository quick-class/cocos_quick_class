--[[ 
	- 带特定动作的按钮 
    local myButton = MyButton.new({normal = "img/star.png"},self,function()
        print("listener")
    end)
	myButton:getButton()
			:pos(300,200)
			:addTo(self)
end)
--]]
local MyButton = class("MyButton")
function MyButton:ctor(params,scene,listener)
    self.listener = listener
    self.button = cc.ui.UIPushButton.new("img/star.png")
        --:center()
        --:addTo(scene)
end
function MyButton:getButton()
    local time = 0.1
    local offset = 40
    self.button:onButtonClicked(function()
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
                onComplete = self.listener
            })    
        end})
    end)
    
    return self.button
end
return MyButton