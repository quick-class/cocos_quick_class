
-- lol menu
--height 400 width 600
local MyMenu = class("MyMenu")

function MyMenu:ctor(scene)
    self.scene = scene
    self.num = 21
    self.index = math.modf(self.num/2)+1
    self.lastIndex = 0
    self.items = {}

    self.animationTime = 0.3
end
function MyMenu:init(items)
    --items 中添加num哥元素
    --    for i=1,self.num,1 do 
    --        self.items[i] = display.newSprite("img/add.png")
    --            :addTo(self.scene)
    --
    --    end
    self.items = items
    self:onTouch()
    self:updatePositionWithAction()
end
--function MyMenu:addItem(menuItem)
--    self.items[#self.items + 1] = menuItem
--    self.num = self.num + 1
--    self.index = math.modf(self.num/2)+1
--end
function MyMenu:updatePosition()
    for i=1,self.num,1 do
        local x = self:calcFunction(i - self.index,400)
        self.items[i]:pos(300+x,200)
            :zorder(-math.abs(i-self.index)*100)
            :scale(1.0 - math.abs(self:calcFunction(i-self.index,1)))
        local orbit = cc.OrbitCamera:create(1,1,0,self:calcFunction(i - self.index, 60.0),self:calcFunction(i - self.index, 60.0) - self:calcFunction(i - self.index, 60.0),0,0)
        self.items[i]:runAction(orbit)
        -- 0,1, 0, calcFunction(i - _lastIndex, MENU_ASLOPE), calcFunction(i - _lastIndex, MENU_ASLOPE) - calcFunction(i - _index, MENU_ASLOPE), 0, 0);  
        --  _items.at(i)->runAction(orbit1);  
    end
end
function MyMenu:updatePositionWithAction()
    for i=1,self.num,1 do
        self.items[i]:stopAllActions()
        local x = self:calcFunction(i - self.index,400)
        self.items[i]:zorder(-math.abs(i-self.index)*100)
        -- :pos(300+x,200)

        --        local moveTo = cc.MoveTo:create(self.animationTime,cc.p(300+x,200))
        --        local scaleTo = cc.ScaleTo:create(self.animationTime,1.0 - math.abs(self:calcFunction(i-self.index,1)))
        --        local orbit = cc.OrbitCamera:create(self.animationTime,1,0,self:calcFunction(i - self.index, 60.0),self:calcFunction(i - self.index, 60.0) - self:calcFunction(i - self.index, 60.0),0,0)
        local action = cc.Spawn:create({
            cc.MoveTo:create(self.animationTime,cc.p(300+x,200)),
            cc.ScaleTo:create(self.animationTime,1.0 - math.abs(self:calcFunction(i-self.index,1))),
            cc.OrbitCamera:create(self.animationTime,1,0,self:calcFunction(i - self.index, 60.0),self:calcFunction(i - self.index, 60.0) - self:calcFunction(i - self.index, 60.0),0,0),
            cc.RotateBy:create(self.animationTime,360)
        })
        --cc.OrbitCamera:create(self.animationTime,1,0,self:calcFunction(i - self.index, 60.0),self:calcFunction(i - self.index, 60.0) - self:calcFunction(i - self.index, 60.0),0,0)
        --self.items[i]:runAction(action)
        transition.execute(self.items[i],action,{
            --delay = 0.1,
            easing = "backOut"
        })
    end
end
function MyMenu:setIndex(index)
    self.lastIndex = self.index
    self.index = index
    self:updatePositionWithAction()
end
--touch
function MyMenu:onTouch()
    local beganX = 0
    self.scene:setTouchEnabled(true)
    self.scene:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
        local flag = true
        if event.name == "began" then
            beganX=event.x
            print("began!")
            return true
        end
        if event.name == "moved" then
        --local delta = event.x - beganX
        end
        if event.name == "ended" then
            if event.x - beganX >= 50 then
                print("move Right")
                if self.index >1  then
                    self.index = self.index - 1
                    self:setIndex(self.index)
                end
                
            elseif event.x - beganX <= -50 then
                print("move Left")
                if self.index <21 then
                    self.index = self.index + 1
                    self:setIndex(self.index)
                end
            end
            print("ended!")
        end
    end)


end
function MyMenu:calcFunction(index,width)
    return width*index / (math.abs(index) + 1);  
end
return MyMenu