<template>
  <view class="mortgage-page">
    <!-- 顶部导航栏 -->
    <uni-nav-bar
      title="房贷计算器"
      background-color="#07C160"
      color="#FFFFFF"
      status-bar="true"
      fixed="true"
      left-icon="back"
      @clickLeft="goBack"
    ></uni-nav-bar>
<view class="mortgage-container">
    <!-- 计算表单 -->
    <view class="calc-form">
      <!-- 贷款类型选择 -->
      <view class="form-section">
        <view class="section-title">贷款类型</view>
        <view class="loan-type-tabs">
          <view 
            class="tab-item" 
            :class="{'active-tab': loanType === 'commercial'}" 
            @click="loanType = 'commercial'"
          >
            <text>商业贷款</text>
          </view>
          <view 
            class="tab-item" 
            :class="{'active-tab': loanType === 'fund'}" 
            @click="loanType = 'fund'"
          >
            <text>公积金贷款</text>
          </view>
          <view 
            class="tab-item" 
            :class="{'active-tab': loanType === 'mixed'}" 
            @click="loanType = 'mixed'"
          >
            <text>组合贷款</text>
          </view>
        </view>
      </view>

      <!-- 还款方式选择 -->
      <view class="form-section">
        <view class="section-title">还款方式</view>
        <view class="repayment-tabs">
          <view 
            class="tab-item" 
            :class="{'active-tab': repaymentMethod === 'equal'}" 
            @click="repaymentMethod = 'equal'"
          >
            <text>等额本息</text>
          </view>
          <view 
            class="tab-item" 
            :class="{'active-tab': repaymentMethod === 'principal'}" 
            @click="repaymentMethod = 'principal'"
          >
            <text>等额本金</text>
          </view>
        </view>
      </view>

      <!-- 贷款金额 -->
      <view class="form-section">
        <view class="section-title">贷款金额(万元)</view>
        <view class="input-group">
          <input 
            type="digit" 
            v-model="loanAmount" 
            placeholder="请输入贷款金额" 
            class="form-input"
          />
        </view>
      </view>

      <!-- 贷款期限 -->
      <view class="form-section">
        <view class="section-title">贷款期限(年)</view>
        <view class="slider-container">
          <slider 
            :value="loanYears" 
            :min="1" 
            :max="30" 
            :step="1" 
            show-value 
            @change="handleYearsChange"
            activeColor="#07C160"
          />
        </view>
      </view>

      <!-- 贷款利率 -->
      <view class="form-section">
        <view class="section-title">
          贷款利率(%)
          <text class="rate-tip">LPR基准利率: {{ lprRate }}%</text>
        </view>
        <view class="input-group">
          <input 
            type="digit" 
            v-model="interestRate" 
            placeholder="请输入贷款利率" 
            class="form-input"
          />
        </view>
      </view>

      <!-- 组合贷款额外字段 -->
      <block v-if="loanType === 'mixed'">
        <view class="form-section">
          <view class="section-title">商业贷款金额(万元)</view>
          <view class="input-group">
            <input 
              type="digit" 
              v-model="commercialAmount" 
              placeholder="请输入商业贷款金额" 
              class="form-input"
            />
          </view>
        </view>

        <view class="form-section">
          <view class="section-title">商业贷款利率(%)</view>
          <view class="input-group">
            <input 
              type="digit" 
              v-model="commercialRate" 
              placeholder="请输入商业贷款利率" 
              class="form-input"
            />
          </view>
        </view>

        <view class="form-section">
          <view class="section-title">公积金贷款金额(万元)</view>
          <view class="input-group">
            <input 
              type="digit" 
              v-model="fundAmount" 
              placeholder="请输入公积金贷款金额" 
              class="form-input"
            />
          </view>
        </view>

        <view class="form-section">
          <view class="section-title">公积金贷款利率(%)</view>
          <view class="input-group">
            <input 
              type="digit" 
              v-model="fundRate" 
              placeholder="请输入公积金贷款利率" 
              class="form-input"
            />
          </view>
        </view>
      </block>

      <!-- 计算按钮 -->
      <view class="calc-button" @click="calculateMortgage">
        <text>计算结果</text>
      </view>
    </view>

    <!-- 计算结果 -->
    <view class="result-section" v-if="showResult">
      <view class="result-header">
        <text class="result-title">计算结果</text>
      </view>

      <view class="result-card">
        <view class="result-item">
          <text class="item-label">贷款总额</text>
          <text class="item-value">{{ formatMoney(totalLoan) }}万元</text>
        </view>
        <view class="result-item">
          <text class="item-label">总利息</text>
          <text class="item-value">{{ formatMoney(totalInterest) }}万元</text>
        </view>
        <view class="result-item">
          <text class="item-label">本息合计</text>
          <text class="item-value">{{ formatMoney(totalPayment) }}万元</text>
        </view>
        <view class="result-item">
          <text class="item-label">月供</text>
          <text class="item-value primary">{{ formatMoney(monthlyPayment) }}元</text>
        </view>
        <view class="result-item" v-if="repaymentMethod === 'principal'">
          <text class="item-label">首月月供</text>
          <text class="item-value primary">{{ formatMoney(firstMonthPayment) }}元</text>
        </view>
        <view class="result-item" v-if="repaymentMethod === 'principal'">
          <text class="item-label">每月递减</text>
          <text class="item-value">{{ formatMoney(monthlyDecrease) }}元</text>
        </view>
      </view>

      <!-- 月供明细表 -->
      <view class="payment-details" v-if="showDetails">
        <view class="details-header">
          <text class="details-title">月供明细表</text>
          <view class="details-toggle" @click="toggleDetails">
            <text>{{ showDetails ? '收起' : '展开' }}</text>
            <uni-icons :type="showDetails ? 'top' : 'bottom'" size="14" color="#07C160"></uni-icons>
          </view>
        </view>

        <view class="details-table">
          <view class="table-header">
            <text class="table-cell">期数</text>
            <text class="table-cell">月供</text>
            <text class="table-cell">本金</text>
            <text class="table-cell">利息</text>
            <text class="table-cell">剩余本金</text>
          </view>
          <view class="table-row" v-for="(item, index) in paymentSchedule" :key="index">
            <text class="table-cell">{{ item.period }}</text>
            <text class="table-cell">{{ formatMoney(item.payment) }}</text>
            <text class="table-cell">{{ formatMoney(item.principal) }}</text>
            <text class="table-cell">{{ formatMoney(item.interest) }}</text>
            <text class="table-cell">{{ formatMoney(item.remainingPrincipal) }}</text>
          </view>
        </view>
      </view>

      <view class="payment-details-toggle" v-if="!showDetails" @click="toggleDetails">
        <text>查看月供明细表</text>
        <uni-icons type="bottom" size="14" color="#07C160"></uni-icons>
      </view>
    </view>
  </view>
</view>  
</template>

<script>
import { uniIcons } from '@dcloudio/uni-ui';

export default {
  components: {
    uniIcons
  },
  data() {
    return {
      // 贷款类型: 商业贷款、公积金贷款、组合贷款
      loanType: 'commercial',
      // 还款方式: 等额本息、等额本金
      repaymentMethod: 'equal',
      // 贷款金额(万元)
      loanAmount: 100,
      // 贷款期限(年)
      loanYears: 20,
      // 贷款利率(%)
      interestRate: 4.1,
      // LPR基准利率
      lprRate: 4.1,
      
      // 组合贷款参数
      commercialAmount: 70,
      commercialRate: 4.1,
      fundAmount: 30,
      fundRate: 3.1,
      
      // 计算结果
      showResult: false,
      totalLoan: 0,
      totalInterest: 0,
      totalPayment: 0,
      monthlyPayment: 0,
      firstMonthPayment: 0,
      monthlyDecrease: 0,
      
      // 月供明细
      showDetails: false,
      paymentSchedule: []
    };
  },
  methods: {
    goBack() {
      uni.navigateBack();
    },
    
    handleYearsChange(e) {
      this.loanYears = e.detail.value;
    },
    
    toggleDetails() {
      this.showDetails = !this.showDetails;
    },
    
    // 计算房贷
    calculateMortgage() {
      // 验证输入
      if (!this.validateInput()) {
        return;
      }
      
      let totalLoan = 0;
      let totalInterest = 0;
      let monthlyPayment = 0;
      let firstMonthPayment = 0;
      let monthlyDecrease = 0;
      
      // 根据贷款类型计算
      if (this.loanType === 'mixed') {
        // 组合贷款计算
        const commercialLoan = parseFloat(this.commercialAmount) * 10000;
        const fundLoan = parseFloat(this.fundAmount) * 10000;
        const commercialRate = parseFloat(this.commercialRate) / 100 / 12;
        const fundRate = parseFloat(this.fundRate) / 100 / 12;
        const months = this.loanYears * 12;
        
        totalLoan = commercialLoan + fundLoan;
        
        if (this.repaymentMethod === 'equal') {
          // 等额本息
          const commercialMonthly = this.calculateEqualPayment(commercialLoan, commercialRate, months);
          const fundMonthly = this.calculateEqualPayment(fundLoan, fundRate, months);
          
          monthlyPayment = commercialMonthly + fundMonthly;
          totalInterest = (monthlyPayment * months) - totalLoan;
        } else {
          // 等额本金
          const commercialResult = this.calculatePrincipalPayment(commercialLoan, commercialRate, months);
          const fundResult = this.calculatePrincipalPayment(fundLoan, fundRate, months);
          
          firstMonthPayment = commercialResult.firstMonth + fundResult.firstMonth;
          monthlyDecrease = commercialResult.decrease + fundResult.decrease;
          totalInterest = commercialResult.totalInterest + fundResult.totalInterest;
        }
      } else {
        // 商业贷款或公积金贷款
        totalLoan = parseFloat(this.loanAmount) * 10000;
        const monthlyRate = parseFloat(this.interestRate) / 100 / 12;
        const months = this.loanYears * 12;
        
        if (this.repaymentMethod === 'equal') {
          // 等额本息
          monthlyPayment = this.calculateEqualPayment(totalLoan, monthlyRate, months);
          totalInterest = (monthlyPayment * months) - totalLoan;
        } else {
          // 等额本金
          const result = this.calculatePrincipalPayment(totalLoan, monthlyRate, months);
          firstMonthPayment = result.firstMonth;
          monthlyDecrease = result.decrease;
          totalInterest = result.totalInterest;
        }
      }
      
      // 更新计算结果
      this.totalLoan = totalLoan / 10000; // 转换为万元
      this.totalInterest = totalInterest / 10000; // 转换为万元
      this.totalPayment = (totalLoan + totalInterest) / 10000; // 转换为万元
      this.monthlyPayment = this.repaymentMethod === 'equal' ? monthlyPayment : 0;
      this.firstMonthPayment = firstMonthPayment;
      this.monthlyDecrease = monthlyDecrease;
      
      // 生成月供明细表
      this.generatePaymentSchedule();
      
      // 显示结果
      this.showResult = true;
    },
    
    // 等额本息月供计算
    calculateEqualPayment(loan, monthlyRate, months) {
      return loan * monthlyRate * Math.pow(1 + monthlyRate, months) / (Math.pow(1 + monthlyRate, months) - 1);
    },
    
    // 等额本金计算
    calculatePrincipalPayment(loan, monthlyRate, months) {
      const monthlyPrincipal = loan / months;
      const firstMonthInterest = loan * monthlyRate;
      const firstMonth = monthlyPrincipal + firstMonthInterest;
      const decrease = monthlyPrincipal * monthlyRate;
      
      let totalInterest = 0;
      let remainingPrincipal = loan;
      
      for (let i = 0; i < months; i++) {
        const interest = remainingPrincipal * monthlyRate;
        totalInterest += interest;
        remainingPrincipal -= monthlyPrincipal;
      }
      
      return {
        firstMonth,
        decrease,
        totalInterest
      };
    },
    
    // 生成月供明细表
    generatePaymentSchedule() {
      const schedule = [];
      const months = this.loanYears * 12;
      let loan = parseFloat(this.loanAmount) * 10000;
      const monthlyRate = parseFloat(this.interestRate) / 100 / 12;
      
      if (this.repaymentMethod === 'equal') {
        // 等额本息
        const monthlyPayment = this.calculateEqualPayment(loan, monthlyRate, months);
        let remainingPrincipal = loan;
        
        // 只生成前12期和最后一期的数据
        for (let i = 1; i <= Math.min(12, months); i++) {
          const interest = remainingPrincipal * monthlyRate;
          const principal = monthlyPayment - interest;
          remainingPrincipal -= principal;
          
          schedule.push({
            period: i,
            payment: monthlyPayment,
            principal: principal,
            interest: interest,
            remainingPrincipal: remainingPrincipal
          });
        }
        
        // 如果贷款期限超过12个月，添加最后一期
        if (months > 12) {
          // 计算最后一期的数据
          remainingPrincipal = loan;
          for (let i = 1; i < months; i++) {
            const interest = remainingPrincipal * monthlyRate;
            const principal = monthlyPayment - interest;
            remainingPrincipal -= principal;
          }
          
          const lastInterest = remainingPrincipal * monthlyRate;
          const lastPrincipal = remainingPrincipal;
          const lastPayment = lastPrincipal + lastInterest;
          
          schedule.push({
            period: months,
            payment: lastPayment,
            principal: lastPrincipal,
            interest: lastInterest,
            remainingPrincipal: 0
          });
        }
      } else {
        // 等额本金
        const monthlyPrincipal = loan / months;
        let remainingPrincipal = loan;
        
        // 只生成前12期和最后一期的数据
        for (let i = 1; i <= Math.min(12, months); i++) {
          const interest = remainingPrincipal * monthlyRate;
          const payment = monthlyPrincipal + interest;
          remainingPrincipal -= monthlyPrincipal;
          
          schedule.push({
            period: i,
            payment: payment,
            principal: monthlyPrincipal,
            interest: interest,
            remainingPrincipal: remainingPrincipal
          });
        }
        
        // 如果贷款期限超过12个月，添加最后一期
        if (months > 12) {
          remainingPrincipal = monthlyPrincipal;
          const lastInterest = remainingPrincipal * monthlyRate;
          const lastPayment = monthlyPrincipal + lastInterest;
          
          schedule.push({
            period: months,
            payment: lastPayment,
            principal: monthlyPrincipal,
            interest: lastInterest,
            remainingPrincipal: 0
          });
        }
      }
      
      this.paymentSchedule = schedule;
    },
    
    // 验证输入
    validateInput() {
      if (this.loanType === 'mixed') {
        if (!this.commercialAmount || !this.fundAmount || !this.commercialRate || !this.fundRate) {
          uni.showToast({
            title: '请填写完整的贷款信息',
            icon: 'none'
          });
          return false;
        }
      } else {
        if (!this.loanAmount || !this.interestRate) {
          uni.showToast({
            title: '请填写完整的贷款信息',
            icon: 'none'
          });
          return false;
        }
      }
      
      return true;
    },
    
    // 格式化金额
    formatMoney(value) {
      return parseFloat(value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }
  },
  onLoad() {
    // 初始化LPR基准利率
    this.lprRate = 4.1;
  }
};
</script>

<style>
.mortgage-container {
  padding: 40rpx 20rpx 40rpx 20rpx;
  background-color: #f8f8f8;
}

.mortgage-container .calc-form {
  background-color: #fff;
  border-radius: 16rpx;
  padding: 30rpx;
  margin-bottom: 20rpx;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.05);
}

.mortgage-container .calc-form .form-section {
  margin-bottom: 30rpx;
}

.mortgage-container .calc-form .form-section .section-title {
  font-size: 28rpx;
  color: #666;
  margin-bottom: 16rpx;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.mortgage-container .calc-form .form-section .section-title .rate-tip {
  font-size: 24rpx;
  color: #07C160;
}

.mortgage-container .calc-form .loan-type-tabs,
.mortgage-container .calc-form .repayment-tabs {
  display: flex;
  background-color: #f5f5f5;
  border-radius: 12rpx;
  overflow: hidden;
}

.mortgage-container .calc-form .loan-type-tabs .tab-item,
.mortgage-container .calc-form .repayment-tabs .tab-item {
  flex: 1;
  text-align: center;
  padding: 20rpx 0;
  font-size: 28rpx;
  color: #666;
  transition: all 0.3s;
}

.mortgage-container .calc-form .tab-container .tab-item.active-tab {
  background-color: #07C160;
  color: #fff;
  font-weight: 500;
}

.mortgage-container .calc-form .input-group {
  position: relative;
}

.mortgage-container .calc-form .input-group .form-input {
  width: 100%;
  height: 80rpx;
  background-color: #f5f5f5;
  border-radius: 12rpx;
  padding: 0 20rpx;
  font-size: 28rpx;
  color: #333;
}

.mortgage-container .calc-form .slider-container {
  padding: 10rpx 0;
}

.mortgage-container .calc-form .calc-button {
  background: linear-gradient(135deg, #34D399, #07C160);
  height: 90rpx;
  border-radius: 45rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 40rpx;
  box-shadow: 0 6rpx 16rpx rgba(7, 193, 96, 0.3);
}

.mortgage-container .calc-form .calc-button text {
  color: #fff;
  font-size: 32rpx;
  font-weight: 500;
}

.mortgage-container .calc-form .calc-button:active {
  transform: scale(0.98);
}

.mortgage-container .result-section {
  background-color: #fff;
  border-radius: 16rpx;
  padding: 30rpx;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.05);
}

.mortgage-container .result-section .result-header {
  margin-bottom: 20rpx;
}

.mortgage-container .result-section .result-header .result-title {
  font-size: 32rpx;
  font-weight: bold;
  color: #333;
}

.mortgage-container .result-section .result-card {
  background-color: #f9f9f9;
  border-radius: 12rpx;
  padding: 20rpx;
  margin-bottom: 30rpx;
}

.mortgage-container .result-section .result-card .result-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16rpx 0;
  border-bottom: 1rpx solid #eee;
}

.mortgage-container .result-section .result-card .result-item:last-child {
  border-bottom: none;
}

.mortgage-container .result-section .result-card .result-item .item-label {
  font-size: 28rpx;
  color: #666;
}

.mortgage-container .result-section .result-card .result-item .item-value {
  font-size: 28rpx;
  color: #333;
  font-weight: 500;
}

.mortgage-container .result-section .result-card .result-item .item-value.primary {
  color: #07C160;
  font-size: 32rpx;
  font-weight: bold;
}

.mortgage-container .result-section .payment-details {
  margin-top: 30rpx;
}

.mortgage-container .result-section .payment-details .details-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20rpx;
}

.mortgage-container .result-section .payment-details .details-header .details-title {
  font-size: 28rpx;
  font-weight: bold;
  color: #333;
}

.mortgage-container .result-section .payment-details .details-header .details-toggle {
  display: flex;
  align-items: center;
}

.mortgage-container .result-section .payment-details .details-header .details-toggle text {
  font-size: 24rpx;
  color: #07C160;
  margin-right: 6rpx;
}

.mortgage-container .result-section .payment-details .details-table {
  border: 1rpx solid #eee;
  border-radius: 8rpx;
  overflow: hidden;
}

.mortgage-container .result-section .payment-details .details-table .table-header {
  display: flex;
  background-color: #f5f5f5;
  font-weight: 500;
}

.mortgage-container .result-section .payment-details .details-table .table-header .table-cell {
  flex: 1;
  padding: 16rpx 10rpx;
  font-size: 24rpx;
  color: #666;
  text-align: center;
  border-right: 1rpx solid #eee;
}

.mortgage-container .result-section .payment-details .details-table .table-header .table-cell:last-child {
  border-right: none;
}

.mortgage-container .result-section .payment-details .details-table .table-row {
  display: flex;
  border-top: 1rpx solid #eee;
}

.mortgage-container .result-section .payment-details .details-table .table-row .table-cell {
  flex: 1;
  padding: 16rpx 10rpx;
  font-size: 24rpx;
  color: #333;
  text-align: center;
  border-right: 1rpx solid #eee;
}

.mortgage-container .result-section .payment-details .details-table .table-row .table-cell:last-child {
  border-right: none;
}

.mortgage-container .result-section .payment-details .details-table .table-row:nth-child(even) {
  background-color: #f9f9f9;
}

.mortgage-container .result-section .payment-details-toggle {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 30rpx;
  padding: 16rpx 0;
  border-top: 1rpx dashed #eee;
}

.mortgage-container .result-section .payment-details-toggle text {
  font-size: 26rpx;
  color: #07C160;
  margin-right: 6rpx;
}
</style>