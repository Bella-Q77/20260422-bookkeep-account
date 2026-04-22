<template>
  <view class="saving-page">
    <!-- 顶部导航栏 -->
    <uni-nav-bar 
      title="储蓄计划" 
      background-color="#07C160" 
      color="#FFFFFF" 
      status-bar="true"
      fixed="true"
      left-icon="back"
      @clickLeft="goBack"
    ></uni-nav-bar>
<view class="saving-container">
    <view class="form-section">
      <view class="form-item">
        <text class="label">目标金额</text>
        <input class="input" type="number" v-model="targetAmount" placeholder="请输入目标金额" />
      </view>
      
      <view class="form-item">
        <text class="label">当前储蓄</text>
        <input class="input" type="number" v-model="currentSaving" placeholder="请输入当前储蓄" />
      </view>
      
      <view class="form-item">
        <text class="label">每月储蓄</text>
        <input class="input" type="number" v-model="monthlySaving" placeholder="请输入每月储蓄" />
      </view>
      
      <view class="form-item">
        <text class="label">年化收益率(%)</text>
        <input class="input" type="number" v-model="annualRate" placeholder="请输入年化收益率" />
      </view>
    </view>

    <button class="calculate-btn" @click="calculate">计算</button>

    <view class="result-section" v-if="showResult">
      <view class="result-item">
        <text class="label">达成时间</text>
        <text class="value">{{ result.months }}个月 ({{ result.years }}年)</text>
      </view>
      
      <view class="result-item">
        <text class="label">总储蓄</text>
        <text class="value">{{ result.totalSaving }}</text>
      </view>
      
      <view class="result-item">
        <text class="label">总收益</text>
        <text class="value">{{ result.totalInterest }}</text>
      </view>
    </view>

    <view class="history-section" v-if="savingPlans.length > 0">
      <view class="section-header">
        <text class="title">历史计划</text>
      </view>
      
      <view class="plan-item" v-for="(plan, index) in savingPlans" :key="index" @click="loadPlan(plan)">
        <text class="name">{{ plan.name }}</text>
        <text class="target">{{ plan.targetAmount }}元</text>
      </view>
    </view>
  </view>
  </view>
</template>

<script>
import uniIcons from '@dcloudio/uni-ui/lib/uni-icons/uni-icons.vue'

export default {
  components: {
    uniIcons
  },
  data() {
    return {
      targetAmount: '',
      currentSaving: '',
      monthlySaving: '',
      annualRate: '3',
      showResult: false,
      result: {
        months: 0,
        years: 0,
        totalSaving: 0,
        totalInterest: 0
      },
      savingPlans: []
    }
  },
  methods: {
    calculate() {
      if (!this.validateInput()) return
      
      const target = parseFloat(this.targetAmount)
      const current = parseFloat(this.currentSaving)
      const monthly = parseFloat(this.monthlySaving)
      const rate = parseFloat(this.annualRate) / 100 / 12
      
      let months = 0
      let total = current
      let interest = 0
      
      while (total < target) {
        months++
        interest += total * rate
        total += monthly + (total * rate)
      }
      
      this.result = {
        months: months,
        years: Math.floor(months / 12),
        totalSaving: total.toFixed(2),
        totalInterest: interest.toFixed(2)
      }
      
      this.showResult = true
      
      // 保存到历史记录
      this.savePlan()
    },
    
    validateInput() {
      if (!this.targetAmount || this.targetAmount <= 0) {
        uni.showToast({ title: '请输入有效的目标金额', icon: 'none' })
        return false
      }
      if (!this.monthlySaving || this.monthlySaving <= 0) {
        uni.showToast({ title: '请输入有效的每月储蓄', icon: 'none' })
        return false
      }
      return true
    },
    
    savePlan() {
      this.savingPlans.unshift({
        name: `计划${this.savingPlans.length + 1}`,
        targetAmount: this.targetAmount,
        currentSaving: this.currentSaving,
        monthlySaving: this.monthlySaving,
        annualRate: this.annualRate
      })
      
      // 这里实际应该调用API保存
      // this.$api.saving.savePlan(...)
    },
    
    loadPlan(plan) {
      this.targetAmount = plan.targetAmount
      this.currentSaving = plan.currentSaving
      this.monthlySaving = plan.monthlySaving
      this.annualRate = plan.annualRate
      this.calculate()
    },
    
    goBack() {
      uni.navigateBack()
    }
  },
  async onLoad() {
    // 加载历史计划
    try {
      // 这里实际应该调用API获取
      // const res = await this.$api.saving.getPlans()
      this.savingPlans = [
        { name: '购房首付', targetAmount: '500000', currentSaving: '200000', monthlySaving: '10000', annualRate: '3.5' },
        { name: '教育基金', targetAmount: '200000', currentSaving: '50000', monthlySaving: '5000', annualRate: '3' }
      ]
    } catch (e) {
      console.error(e)
    }
  }
}
</script>

<style scoped>
.saving-page {
  padding: 0;
  background-color: #f5f5f5;
  min-height: 100vh;
}
.saving-container {
  padding: 40rpx 20rpx 40rpx 20rpx;
}
.saving-container .form-section {
  background: #fff;
  border-radius: 16rpx;
  padding: 30rpx;
  margin-bottom: 30rpx;
  box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.05);
}

.saving-container .form-section .form-item {
  margin-bottom: 30rpx;
}

.saving-container .form-section .form-item .label {
  display: block;
  font-size: 30rpx;
  color: #333;
  margin-bottom: 15rpx;
  font-weight: 500;
}

.saving-container .form-section .form-item .input {
  height: 90rpx;
  border: 1rpx solid #e5e5e5;
  border-radius: 12rpx;
  padding: 0 25rpx;
  font-size: 30rpx;
  background: #f9f9f9;
}

.saving-container .form-section .form-item .input:focus {
  border-color: #07C160;
}

.saving-container .calculate-btn {
  height: 100rpx;
  line-height: 100rpx;
  background: #07C160;
  color: #fff;
  font-size: 34rpx;
  border-radius: 12rpx;
  margin-bottom: 30rpx;
  border: none;
  box-shadow: 0 4rpx 12rpx rgba(7, 193, 96, 0.2);
}

.saving-container .calculate-btn:active {
  opacity: 0.9;
}

.saving-container .result-section {
  background: #fff;
  border-radius: 16rpx;
  padding: 30rpx;
  margin-bottom: 30rpx;
  box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.05);
}

.saving-container .result-section .result-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25rpx;
  padding-bottom: 25rpx;
  border-bottom: 1rpx solid #f0f0f0;
}

.saving-container .result-section .result-item:last-child {
  margin-bottom: 0;
  padding-bottom: 0;
  border-bottom: none;
}

.saving-container .result-section .result-item .label {
  font-size: 30rpx;
  color: #666;
}

.saving-container .result-section .result-item .value {
  font-size: 32rpx;
  font-weight: bold;
  color: #07C160;
}

.saving-container .history-section {
  background: #fff;
  border-radius: 16rpx;
  padding: 30rpx;
  box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.05);
}

.saving-container .history-section .section-header {
  margin-bottom: 30rpx;
  padding-bottom: 20rpx;
  border-bottom: 1rpx solid #f0f0f0;
}

.saving-container .history-section .section-header .title {
  font-size: 34rpx;
  font-weight: bold;
  color: #07C160;
}

.saving-container .history-section .plan-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 25rpx;
  background: #f9f9f9;
  border-radius: 12rpx;
  margin-bottom: 20rpx;
  transition: all 0.2s;
}

.saving-container .history-section .plan-item:active {
  background: #f0f0f0;
}

.saving-container .history-section .plan-item .name {
  font-size: 30rpx;
  color: #333;
  font-weight: 500;
}

.saving-container .history-section .plan-item .target {
  font-size: 30rpx;
  color: #07C160;
  font-weight: bold;
}
</style>