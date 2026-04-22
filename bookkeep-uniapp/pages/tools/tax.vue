<template>
  <view class="tax-page">
    <!-- 顶部导航栏 -->
    <uni-nav-bar 
      title="税费计算器" 
      background-color="#07C160" 
      color="#FFFFFF" 
      status-bar="true"
      fixed="true"
      left-icon="back"
      @clickLeft="goBack"
    ></uni-nav-bar>
<view class="tax-container">
    <!-- 计算表单 -->
    <view class="calculator-card">
      <!-- 收入输入 -->
      <view class="input-group">
        <text class="input-label">收入金额</text>
        <input 
          type="digit" 
          v-model="income" 
          placeholder="输入税前收入"
          class="input-field"
          @input="calculateTax"
        />
        <text class="currency-symbol">¥</text>
      </view>

      <!-- 地区选择 -->
      <view class="input-group">
        <text class="input-label">所在地区</text>
        <picker 
          mode="selector" 
          :range="regions" 
          range-key="name"
          @change="onRegionChange"
        >
          <view class="picker">
            {{ selectedRegion.name }}
            <uni-icons type="down" size="14" color="#666"></uni-icons>
          </view>
        </picker>
      </view>

      <!-- 社保公积金选项 -->
      <view class="checkbox-group">
        <text class="checkbox-label">包含社保公积金</text>
        <switch 
          :checked="includeSocialSecurity" 
          @change="toggleSocialSecurity"
          color="#07C160"
        />
      </view>

      <!-- 计算结果 -->
      <view class="result-section" v-if="showResults">
        <view class="result-row">
          <text>应纳税所得额</text>
          <text class="result-value">¥{{ formatNumber(taxableIncome) }}</text>
        </view>
        <view class="result-row">
          <text>应缴税额</text>
          <text class="result-value">¥{{ formatNumber(taxAmount) }}</text>
        </view>
        <view class="result-row">
          <text>社保公积金</text>
          <text class="result-value">¥{{ formatNumber(socialSecurityAmount) }}</text>
        </view>
        <view class="result-row total">
          <text>税后收入</text>
          <text class="result-value">¥{{ formatNumber(netIncome) }}</text>
        </view>
      </view>

      <!-- 计算按钮 -->
      <button 
        class="calculate-button" 
        :disabled="!income" 
        @click="calculateTax"
      >
        计算
      </button>
    </view>

    <!-- 税率表 -->
    <view class="tax-rate-card">
      <view class="card-header">
        <text class="card-title">{{ selectedRegion.name }}税率表</text>
      </view>
      <view class="rate-table">
        <view class="table-header">
          <text>级数</text>
          <text>应纳税所得额</text>
          <text>税率(%)</text>
          <text>速算扣除数</text>
        </view>
        <view 
          class="table-row" 
          v-for="(rate, index) in selectedRegion.rates" 
          :key="index"
          :class="{ active: isRateActive(rate) }"
        >
          <text>{{ index + 1 }}</text>
          <text>{{ rate.range }}</text>
          <text>{{ rate.rate }}%</text>
          <text>{{ rate.quickDeduction }}</text>
        </view>
      </view>
    </view>
  </view>
</view>  
</template>

<script>
import { uniIcons } from '@dcloudio/uni-ui';
import { getTaxRates } from '@/api/tax';
import { regionTaxData } from '@/store/mock/tax';

export default {
  components: {
    uniIcons
  },
  data() {
    return {
      income: '',
      regions: [],
      selectedRegion: {},
      includeSocialSecurity: true,
      showResults: false,
      
      // 计算结果
      taxableIncome: 0,
      taxAmount: 0,
      socialSecurityAmount: 0,
      netIncome: 0
    };
  },
  created() {
    this.loadTaxData();
  },
  methods: {
    goBack() {
      uni.navigateBack();
    },
    
    async loadTaxData() {
      try {
        // 使用模拟数据
        this.regions = regionTaxData;
        this.selectedRegion = this.regions[0];
        
        // 实际API调用 (保留注释)
        // const data = await getTaxRates();
        // this.regions = data;
        // this.selectedRegion = this.regions[0];
      } catch (error) {
        console.error('加载税率数据失败:', error);
        uni.showToast({
          title: '加载税率数据失败',
          icon: 'none'
        });
      }
    },
    
    onRegionChange(e) {
      this.selectedRegion = this.regions[e.detail.value];
      this.calculateTax();
    },
    
    toggleSocialSecurity(e) {
      this.includeSocialSecurity = e.detail.value;
      this.calculateTax();
    },
    
    calculateTax() {
      if (!this.income || isNaN(parseFloat(this.income))) {
        this.showResults = false;
        return;
      }
      
      const incomeValue = parseFloat(this.income);
      
      // 计算社保公积金 (模拟数据)
      this.socialSecurityAmount = this.includeSocialSecurity 
        ? Math.min(incomeValue * 0.22, 3100) 
        : 0;
      
      // 应纳税所得额 = 收入 - 社保公积金 - 起征点(5000)
      this.taxableIncome = Math.max(0, incomeValue - this.socialSecurityAmount - 5000);
      
      // 计算税额
      this.taxAmount = this.calculateTaxAmount(this.taxableIncome);
      
      // 税后收入
      this.netIncome = incomeValue - this.taxAmount - this.socialSecurityAmount;
      
      this.showResults = true;
    },
    
    calculateTaxAmount(amount) {
      if (amount <= 0) return 0;
      
      const rates = this.selectedRegion.rates;
      for (let i = rates.length - 1; i >= 0; i--) {
        const rate = rates[i];
        if (amount > rate.min) {
          return amount * rate.rate / 100 - rate.quickDeduction;
        }
      }
      return 0;
    },
    
    isRateActive(rate) {
      return this.taxableIncome > rate.min && 
             (rate.max === -1 || this.taxableIncome <= rate.max);
    },
    
    formatNumber(num) {
      return parseFloat(num).toFixed(2);
    }
  }
};
</script>

<style scoped>
	
	.tax-page {
	  padding: 0;
	  background-color: #f8f8f8;
	  min-height: 100vh;
	}
	
.tax-container {
  padding: 40rpx 20rpx 40rpx 20rpx;
}

.tax-container .calculator-card {
  padding: 20rpx;
}

.tax-container .calculator-card {
  background-color: #fff;
  border-radius: 16rpx;
  padding: 30rpx;
  margin-bottom: 20rpx;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.05);
}

.tax-container .calculator-card .input-group {
  margin-bottom: 30rpx;
}

.tax-container .calculator-card .input-group .input-label {
  font-size: 28rpx;
  color: #666;
  display: block;
  margin-bottom: 10rpx;
}

.tax-container .calculator-card .input-group .input-field {
  height: 80rpx;
  font-size: 32rpx;
  color: #333;
  border-bottom: 1rpx solid #eee;
  padding: 10rpx 0;
}

.tax-container .calculator-card .input-group .picker {
  height: 80rpx;
  line-height: 80rpx;
  font-size: 32rpx;
  color: #333;
  border-bottom: 1rpx solid #eee;
}

.tax-container .calculator-card .checkbox-group {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30rpx;
}

.tax-container .calculator-card .checkbox-group .checkbox-label {
  font-size: 28rpx;
  color: #666;
}

.tax-container .calculator-card .result-section {
  margin-top: 30rpx;
  padding-top: 20rpx;
  border-top: 1rpx dashed #eee;
}

.tax-container .calculator-card .result-section .result-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20rpx;
  font-size: 28rpx;
  color: #666;
}

.tax-container .calculator-card .result-section .result-row.total {
  margin-top: 30rpx;
  padding-top: 20rpx;
  border-top: 1rpx solid #eee;
  font-weight: bold;
  color: #333;
}

.tax-container .calculator-card .result-section .result-row .result-value {
  color: #07C160;
  font-weight: 500;
}

.tax-container .calculator-card .calculate-button {
  margin-top: 30rpx;
  background-color: #07C160;
  color: #fff;
  border-radius: 12rpx;
  height: 80rpx;
  line-height: 80rpx;
  font-size: 32rpx;
}

.tax-container .calculator-card .calculate-button[disabled] {
  background-color: #ccc;
  opacity: 0.7;
}

.tax-container .tax-rate-card {
  background-color: #fff;
  border-radius: 16rpx;
  padding: 30rpx;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.05);
  margin-top: 20rpx;
}

.tax-container .tax-rate-card .card-header {
  margin-bottom: 20rpx;
}

.tax-container .tax-rate-card .card-header .card-title {
  font-size: 32rpx;
  font-weight: bold;
  color: #333;
}

.tax-container .tax-rate-card .rate-table .table-header,
.tax-container .tax-rate-card .rate-table .table-row {
  display: flex;
  padding: 15rpx 0;
  border-bottom: 1rpx solid #f5f5f5;
  font-size: 24rpx;
}

.tax-container .tax-rate-card .rate-table .table-header text,
.tax-container .tax-rate-card .rate-table .table-row text {
  flex: 1;
  text-align: center;
}

.tax-container .tax-rate-card .rate-table .table-header {
  font-weight: bold;
  color: #333;
}

.tax-container .tax-rate-card .rate-table .table-row {
  color: #666;
}

.tax-container .tax-rate-card .rate-table .table-row.active {
  background-color: #f0f9eb;
  color: #07C160;
  font-weight: 500;
}
</style>