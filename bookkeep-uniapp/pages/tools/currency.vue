<template>
  <view class="currency-container">
    <!-- 顶部导航栏 -->
    <uni-nav-bar 
      title="汇率换算" 
      background-color="#07C160" 
      color="#FFFFFF" 
      status-bar="true"
      fixed="true"
      left-icon="back"
      @clickLeft="goBack"
    ></uni-nav-bar>

    <!-- 汇率转换表单 -->
    <view class="converter-card">
      <!-- 金额输入 -->
      <view class="amount-input">
        <input 
          type="digit" 
          v-model="amount" 
          placeholder="输入金额" 
          @input="handleAmountChange"
          class="input-field"
        />
      </view>

      <!-- 货币选择区域 -->
      <view class="currency-selection">
        <!-- 源货币 -->
        <view class="currency-block">
          <view class="currency-label">从</view>
          <view class="currency-picker" @click="openCurrencyPicker('from')">
            <view class="currency-flag">{{ getCurrencyFlag(fromCurrency) }}</view>
            <view class="currency-code">{{ fromCurrency }}</view>
            <uni-icons type="down" size="14" color="#666"></uni-icons>
          </view>
        </view>

        <!-- 交换按钮 -->
        <view class="swap-button" @click="swapCurrencies">
          <uni-icons type="loop" size="24" color="#07C160"></uni-icons>
        </view>

        <!-- 目标货币 -->
        <view class="currency-block">
          <view class="currency-label">到</view>
          <view class="currency-picker" @click="openCurrencyPicker('to')">
            <view class="currency-flag">{{ getCurrencyFlag(toCurrency) }}</view>
            <view class="currency-code">{{ toCurrency }}</view>
            <uni-icons type="down" size="14" color="#666"></uni-icons>
          </view>
        </view>
      </view>

      <!-- 转换结果 -->
      <view class="conversion-result">
        <view class="result-amount">{{ formattedResult }}</view>
        <view class="result-details">
          <text>1 {{ fromCurrency }} = {{ getExchangeRate(fromCurrency, toCurrency) }} {{ toCurrency }}</text>
          <text>更新时间: {{ formattedUpdateTime }}</text>
        </view>
      </view>
    </view>

    <!-- 常用货币汇率列表 -->
    <view class="rates-card">
      <view class="card-header">
        <text class="card-title">{{ fromCurrency }} 汇率表</text>
        <view class="refresh-button" @click="refreshRates">
          <uni-icons type="refresh" size="18" color="#07C160"></uni-icons>
        </view>
      </view>

      <view class="rates-list">
        <view class="rate-item" v-for="currency in popularCurrencies" :key="currency.code">
          <view class="currency-info">
            <text class="currency-flag">{{ currency.flag }}</text>
            <view class="currency-details">
              <text class="currency-name">{{ currency.name }}</text>
              <text class="currency-code">{{ currency.code }}</text>
            </view>
          </view>
          <view class="rate-value">
            <text>{{ getExchangeRate(fromCurrency, currency.code) }}</text>
          </view>
        </view>
      </view>
    </view>

    <!-- 历史查询记录 -->
    <view class="history-card" v-if="conversionHistory.length > 0">
      <view class="card-header">
        <text class="card-title">历史查询</text>
        <view class="clear-button" @click="clearHistory">
          <text>清除</text>
        </view>
      </view>

      <view class="history-list">
        <view class="history-item" v-for="(item, index) in conversionHistory" :key="index" @click="applyHistory(item)">
          <view class="history-amount">{{ item.amount }} {{ item.fromCurrency }}</view>
          <uni-icons type="arrow-right" size="14" color="#999"></uni-icons>
          <view class="history-result">{{ item.result }} {{ item.toCurrency }}</view>
        </view>
      </view>
    </view>

    <!-- 自定义货币选择弹窗 - From -->
    <view class="custom-popup" v-if="showFromCurrencyPicker">
      <view class="popup-mask" @click="closeCurrencyPicker('from')"></view>
      <view class="popup-content">
        <view class="currency-popup">
          <view class="popup-header">
            <text>选择货币</text>
            <view class="close-button" @click="closeCurrencyPicker('from')">
              <uni-icons type="close" size="20" color="#666"></uni-icons>
            </view>
          </view>
          <view class="search-box">
            <uni-icons type="search" size="18" color="#999"></uni-icons>
            <input 
              type="text" 
              v-model="searchQuery" 
              placeholder="搜索货币" 
              @input="filterCurrencies"
              class="search-input"
            />
          </view>
          <scroll-view scroll-y class="currency-list-scroll">
            <view 
              class="currency-list-item" 
              v-for="currency in filteredCurrencies" 
              :key="currency.code"
              @click="selectCurrency('from', currency.code)"
            >
              <view class="currency-flag">{{ currency.flag }}</view>
              <view class="currency-info">
                <text class="currency-name">{{ currency.name }}</text>
                <text class="currency-code">{{ currency.code }}</text>
              </view>
            </view>
          </scroll-view>
        </view>
      </view>
    </view>

    <!-- 自定义货币选择弹窗 - To -->
    <view class="custom-popup" v-if="showToCurrencyPicker">
      <view class="popup-mask" @click="closeCurrencyPicker('to')"></view>
      <view class="popup-content">
        <view class="currency-popup">
          <view class="popup-header">
            <text>选择货币</text>
            <view class="close-button" @click="closeCurrencyPicker('to')">
              <uni-icons type="close" size="20" color="#666"></uni-icons>
            </view>
          </view>
          <view class="search-box">
            <uni-icons type="search" size="18" color="#999"></uni-icons>
            <input 
              type="text" 
              v-model="searchQuery" 
              placeholder="搜索货币" 
              @input="filterCurrencies"
              class="search-input"
            />
          </view>
          <scroll-view scroll-y class="currency-list-scroll">
            <view 
              class="currency-list-item" 
              v-for="currency in filteredCurrencies" 
              :key="currency.code"
              @click="selectCurrency('to', currency.code)"
            >
              <view class="currency-flag">{{ currency.flag }}</view>
              <view class="currency-info">
                <text class="currency-name">{{ currency.name }}</text>
                <text class="currency-code">{{ currency.code }}</text>
              </view>
            </view>
          </scroll-view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import { uniIcons } from '@dcloudio/uni-ui';
// 注意：这些 mock 函数需要您自己实现或替换为真实 API 调用
// import { fetchCurrencyRates, fetchSupportedCurrencies, convertCurrencyAmount } from '@/api/currency';
import { currencyInfo } from '@/store/mock/currency';

// --- Mock 数据 ---
const mockCurrencyRates = {
  success: true,
  rates: {
    USD: 0.1385,
    EUR: 0.1282,
    GBP: 0.1120,
    JPY: 19.25,
    HKD: 1.075,
    KRW: 181.5,
    AUD: 0.2050,
    CAD: 0.1880,
    CNY: 1.0 // 基准货币自身
  },
  base: 'CNY', // Mock 数据以 CNY 为基准
  timestamp: Date.now()
};

const mockCurrencies = [
  { code: 'USD', name: '美元', flag: '🇺🇸' },
  { code: 'EUR', name: '欧元', flag: '🇪🇺' },
  { code: 'GBP', name: '英镑', flag: '🇬🇧' },
  { code: 'JPY', name: '日元', flag: '🇯🇵' },
  { code: 'CNY', name: '人民币', flag: '🇨🇳' },
  { code: 'KRW', name: '韩元', flag: '🇰🇷' },
  { code: 'HKD', name: '港币', flag: '🇭🇰' },
  { code: 'AUD', name: '澳元', flag: '🇦🇺' },
  { code: 'CAD', name: '加元', flag: '🇨🇦' },
  // ... 更多货币
];
// --- End Mock 数据 ---


export default {
  components: {
    uniIcons
  },
  data() {
    return {
      // 转换参数
      amount: '100',
      fromCurrency: 'CNY',
      toCurrency: 'USD',
      result: 0,
      
      // 汇率数据
      currencyRates: {},
      baseCurrency: 'USD', // 初始值
      lastUpdated: null,
      
      // 货币列表
      allCurrencies: [],
      popularCurrencies: [],
      filteredCurrencies: [],
      
      // UI状态
      loading: false,
      showFromCurrencyPicker: false,
      showToCurrencyPicker: false,
      searchQuery: '',
      
      // 历史记录
      conversionHistory: []
    };
  },
  computed: {
    formattedResult() {
      if (!this.amount || isNaN(this.result)) {
        return '0.0000';
      }
      return this.formatNumber(this.result);
    },
    formattedUpdateTime() {
      if (!this.lastUpdated) {
        return '正在更新...';
      }
      const date = new Date(this.lastUpdated);
      return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')} ${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}`;
    }
  },
  watch: {
    // 监听 fromCurrency 变化
    fromCurrency(newVal, oldVal) {
      // console.log(`fromCurrency changed from ${oldVal} to ${newVal}`);
      this.loadCurrencyRates();
      // convertAmount 会在 loadCurrencyRates 成功后内部调用
    },
    // 新增：监听 toCurrency 变化
    toCurrency(newVal, oldVal) {
      // console.log(`toCurrency changed from ${oldVal} to ${newVal}`);
      // 当目标货币改变时，如果汇率数据已加载（基于 fromCurrency），则直接计算
      if (Object.keys(this.currencyRates).length > 0 && this.baseCurrency === this.fromCurrency) {
          this.convertAmount();
      }
      // 如果汇率数据未加载或基准货币不匹配（理论上不太可能，因为 fromCurrency watcher 会先触发），
      // 可以选择不处理或重新加载，但通常 fromCurrency watcher 已经处理了。
    },
    // 监听 amount 变化
    amount(newVal, oldVal) {
      // console.log(`amount changed from ${oldVal} to ${newVal}`);
      // 当金额改变时，如果汇率数据已加载，则直接计算
       if (Object.keys(this.currencyRates).length > 0 && this.baseCurrency === this.fromCurrency) {
          this.convertAmount();
       }
    }
  },
  methods: {
    goBack() {
      uni.navigateBack();
    },

    openCurrencyPicker(type) {
      this.searchQuery = '';
      this.filteredCurrencies = [...this.allCurrencies];
      if (type === 'from') {
        this.showFromCurrencyPicker = true;
      } else if (type === 'to') {
        this.showToCurrencyPicker = true;
      }
    },

    closeCurrencyPicker(type) {
      if (type === 'from') {
        this.showFromCurrencyPicker = false;
      } else if (type === 'to') {
        this.showToCurrencyPicker = false;
      }
    },
    
    // 加载汇率数据
    async loadCurrencyRates() {
      try {
        this.loading = true;
        
        // --- 使用 Mock 数据 ---
        // const data = await fetchCurrencyRates(this.fromCurrency);
        const data = { ...mockCurrencyRates, base: this.fromCurrency }; // Mock 数据模拟 API 返回
        // --- End Mock 数据 ---
        
        if (data.success) {
          this.currencyRates = data.rates;
          this.baseCurrency = data.base;
          this.lastUpdated = data.timestamp;
          this.convertAmount(); // 加载新汇率后重新计算
        } else {
          uni.showToast({
            title: '获取汇率数据失败',
            icon: 'none'
          });
        }
      } catch (error) {
        console.error('加载汇率数据失败:', error);
        uni.showToast({
          title: '网络错误，请稍后重试',
          icon: 'none'
        });
      } finally {
        this.loading = false;
      }
    },
    
    // 加载货币列表
    loadCurrencies() {
      try {
        // --- 使用 Mock 数据 ---
        // const currencies = fetchSupportedCurrencies();
        const currencies = mockCurrencies;
        // --- End Mock 数据 ---
        
        this.allCurrencies = currencies;
        this.filteredCurrencies = currencies;
        
        // 设置常用货币
        const popularCodes = ['USD', 'EUR', 'GBP', 'JPY', 'HKD', 'KRW', 'AUD', 'CAD'];
        this.popularCurrencies = currencies.filter(c => popularCodes.includes(c.code));
      } catch (error) {
        console.error('加载货币列表失败:', error);
      }
    },
    
    // 转换金额 (核心修改)
    convertAmount() {
      if (!this.amount || isNaN(parseFloat(this.amount))) {
        this.result = 0;
        return;
      }
      
      const amountValue = parseFloat(this.amount);
      
      // 确保汇率数据是基于当前 fromCurrency 的
      if (this.baseCurrency !== this.fromCurrency) {
          console.warn(`汇率基准货币 ${this.baseCurrency} 与源货币 ${this.fromCurrency} 不匹配，等待重新加载...`);
          // 这种情况理论上由 watcher 处理，但如果发生，可以在这里触发加载
          // this.loadCurrencyRates(); 
          this.result = 0; // 暂时设置为0直到数据加载完成
          return;
      }
      
      // 获取目标货币的汇率
      const rate = this.currencyRates[this.toCurrency];
      
      if (rate === undefined) {
          console.warn(`找不到货币 ${this.toCurrency} 相对于 ${this.fromCurrency} 的汇率`);
          this.result = 0;
          return;
      }
      
      // 计算结果
      this.result = amountValue * rate;
      
      // 添加到历史记录 (注意：在 fromCurrency 变化时调用 loadCurrencyRates 后再调用 convertAmount 会触发此逻辑)
      // this.addToHistory(amountValue, this.result);
    },
    
    // 处理金额变化 (可以简化，因为 watch 会处理)
    handleAmountChange() {
      // 逻辑已移至 watch
    },
    
    // 交换货币 (核心修改)
    swapCurrencies() {
      const temp = this.fromCurrency;
      this.fromCurrency = this.toCurrency;
      this.toCurrency = temp;
      // fromCurrency 的 watch 会触发 loadCurrencyRates 和 convertAmount
      // toCurrency 的 watch 会在 fromCurrency watcher 完成后触发 convertAmount
    },
    
    // 刷新汇率
    refreshRates() {
      this.loadCurrencyRates();
    },
    
    // 获取货币国旗
    getCurrencyFlag(code) {
      return currencyInfo[code]?.flag || '🏳️';
    },
    
    // 获取汇率 (主要用于显示汇率表，核心逻辑在 convertAmount)
    getExchangeRate(from, to) {
      // 确保是从当前基础货币计算的汇率
      if (this.baseCurrency !== from) {
          // console.warn(`汇率基准货币 ${this.baseCurrency} 与源货币 ${from} 不匹配`);
          return 'N/A';
      }
      if (!this.currencyRates || this.currencyRates[to] === undefined) {
        return '加载中...';
      }
      
      const rate = this.currencyRates[to];
      return this.formatNumber(rate);
    },
    
    // 格式化数字
    formatNumber(num) {
      return parseFloat(num).toFixed(4);
    },
    
    // 筛选货币
    filterCurrencies() {
      if (!this.searchQuery) {
        this.filteredCurrencies = [...this.allCurrencies];
        return;
      }
      
      const query = this.searchQuery.toLowerCase();
      this.filteredCurrencies = this.allCurrencies.filter(currency => 
        currency.code.toLowerCase().includes(query) || 
        currency.name.toLowerCase().includes(query)
      );
    },
    
    // 选择货币
    selectCurrency(type, code) {
      if (type === 'from') {
        this.fromCurrency = code;
        // fromCurrency 的 watch 会处理 loadCurrencyRates 和 convertAmount
        this.closeCurrencyPicker('from');
      } else {
        this.toCurrency = code;
        // toCurrency 的 watch 会处理 convertAmount (如果汇率已加载)
        this.closeCurrencyPicker('to');
      }
    },
    
    // 添加到历史记录
    addToHistory(amount, result) {
      // 避免在加载初始汇率时添加空记录
      if (amount === 0 && result === 0) return;

      const newRecord = {
        amount,
        fromCurrency: this.fromCurrency,
        toCurrency: this.toCurrency,
        result,
        timestamp: new Date().getTime()
      };

      // 检查是否已存在相同的记录 (基于金额、源、目标货币)
      const existingIndex = this.conversionHistory.findIndex(item => 
        item.amount === newRecord.amount && 
        item.fromCurrency === newRecord.fromCurrency && 
        item.toCurrency === newRecord.toCurrency
      );

      if (existingIndex !== -1) {
        // 如果存在，更新结果和时间戳
        this.conversionHistory[existingIndex] = newRecord;
      } else {
        // 添加新记录到开头
        this.conversionHistory.unshift(newRecord);
      }
      
      // 限制历史记录数量
      if (this.conversionHistory.length > 10) {
        this.conversionHistory = this.conversionHistory.slice(0, 10);
      }
      
      // 保存到本地存储
      this.saveHistory();
    },
    
    // 保存历史记录
    saveHistory() {
      try {
        uni.setStorageSync('currency_history', JSON.stringify(this.conversionHistory));
      } catch (e) {
        console.error('保存历史记录失败:', e);
      }
    },
    
    // 加载历史记录
    loadHistory() {
      try {
        const history = uni.getStorageSync('currency_history');
        if (history) {
          this.conversionHistory = JSON.parse(history);
        }
      } catch (e) {
        console.error('加载历史记录失败:', e);
      }
    },
    
    // 清除历史记录
    clearHistory() {
      uni.showModal({
        title: '确认清除',
        content: '是否清除所有历史记录？',
        success: (res) => {
          if (res.confirm) {
            this.conversionHistory = [];
            uni.removeStorageSync('currency_history');
          }
        }
      });
    },
    
    // 应用历史记录
    applyHistory(item) {
      this.amount = item.amount.toString();
      this.fromCurrency = item.fromCurrency;
      this.toCurrency = item.toCurrency;
      // watch 会自动更新结果
    }
  },
  onLoad() {
    this.loadCurrencies();
    this.loadCurrencyRates(); // 初始加载汇率
    this.loadHistory();
  }
};
</script>





<style>
/* 基础容器 */
.currency-container {
  padding: 20rpx 20rpx 20rpx 20rpx;
  background-color: #f8f8f8;
  min-height: 100vh;
}

/* 转换卡片 */
.currency-container .converter-card {
  background-color: #fff;
  border-radius: 16rpx;
  padding: 30rpx;
  margin-bottom: 20rpx;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.05);
}

.currency-container .converter-card .amount-input {
  margin-bottom: 30rpx;
}

.currency-container .converter-card .amount-input .input-field {
  height: 100rpx;
  font-size: 48rpx;
  font-weight: bold;
  color: #333;
  border-bottom: 1rpx solid #eee;
  padding: 10rpx 0;
}

.currency-container .converter-card .currency-selection {
  display: flex;
  align-items: center;
  margin-bottom: 30rpx;
}

.currency-container .converter-card .currency-selection .currency-block {
  flex: 1;
}

.currency-container .converter-card .currency-selection .currency-block .currency-label {
  font-size: 24rpx;
  color: #999;
  margin-bottom: 10rpx;
}

.currency-container .converter-card .currency-selection .currency-block .currency-picker {
  display: flex;
  align-items: center;
  background-color: #f5f5f5;
  border-radius: 12rpx;
  padding: 20rpx;
  cursor: pointer;
}

.currency-container .converter-card .currency-selection .currency-block .currency-picker .currency-flag {
  font-size: 32rpx;
  margin-right: 10rpx;
}

.currency-container .converter-card .currency-selection .currency-block .currency-picker .currency-code {
  flex: 1;
  font-size: 28rpx;
  font-weight: 500;
  color: #333;
}

.currency-container .converter-card .currency-selection .swap-button {
  width: 80rpx;
  height: 80rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f5f5f5;
  border-radius: 50%;
  margin: 0 20rpx;
  margin-top: 20rpx;
  cursor: pointer;
}

.currency-container .converter-card .currency-selection .swap-button:active {
  background-color: #e5e5e5;
}

.currency-container .converter-card .conversion-result {
  padding: 30rpx 0;
  border-top: 1rpx dashed #eee;
}

.currency-container .converter-card .conversion-result .result-amount {
  font-size: 48rpx;
  font-weight: bold;
  color: #07C160;
  margin-bottom: 10rpx;
}

.currency-container .converter-card .conversion-result .result-details {
  display: flex;
  flex-direction: column;
}

.currency-container .converter-card .conversion-result .result-details text {
  font-size: 24rpx;
  color: #999;
  margin-bottom: 6rpx;
}

/* 汇率/历史卡片通用样式 */
.rates-card, .history-card {
  background-color: #fff;
  border-radius: 16rpx;
  padding: 30rpx;
  margin-bottom: 20rpx;
  box-shadow: 0 2rpx 10rpx rgba(0, 0, 0, 0.05);
}

.rates-card .card-header, .history-card .card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20rpx;
}

.rates-card .card-header .card-title, .history-card .card-header .card-title {
  font-size: 32rpx;
  font-weight: bold;
  color: #333;
}

.rates-card .card-header .refresh-button, .history-card .card-header .clear-button {
  font-size: 24rpx;
  color: #07C160;
  cursor: pointer;
}

/* 汇率列表 */
.rates-card .rates-list .rate-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20rpx 0;
  border-bottom: 1rpx solid #f5f5f5;
}

.rates-card .rates-list .rate-item:last-child {
  border-bottom: none;
}

.rates-card .rates-list .rate-item .currency-info {
  display: flex;
  align-items: center;
}

.rates-card .rates-list .rate-item .currency-info .currency-flag {
  font-size: 32rpx;
  margin-right: 16rpx;
}

.rates-card .rates-list .rate-item .currency-info .currency-details .currency-name {
  font-size: 28rpx;
  color: #333;
  display: block;
}

.rates-card .rates-list .rate-item .currency-info .currency-details .currency-code {
  font-size: 24rpx;
  color: #999;
}

.rates-card .rates-list .rate-item .rate-value {
  font-size: 28rpx;
  font-weight: 500;
  color: #333;
}

/* 历史列表 */
.history-card .history-list .history-item {
  display: flex;
  align-items: center;
  padding: 20rpx 0;
  border-bottom: 1rpx solid #f5f5f5;
}

.history-card .history-list .history-item:last-child {
  border-bottom: none;
}

.history-card .history-list .history-item:active {
  background-color: #f9f9f9;
}

.history-card .history-list .history-item .history-amount {
  flex: 1;
  font-size: 28rpx;
  color: #333;
}

.history-card .history-list .history-item .history-result {
  flex: 1;
  font-size: 28rpx;
  color: #07C160;
  text-align: right;
}

/* 货币选择弹窗 */
.custom-popup {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 999;
}

.custom-popup .popup-mask {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.4);
}

.custom-popup .popup-content {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #fff;
  border-top-left-radius: 16rpx;
  border-top-right-radius: 16rpx;
  transform: translateY(0);
  transition: transform 0.3s;
}

.currency-popup {
  background-color: #fff;
  border-top-left-radius: 16rpx;
  border-top-right-radius: 16rpx;
  padding: 30rpx;
  max-height: 70vh;
  display: flex;
  flex-direction: column;
}

.currency-popup .popup-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20rpx;
}

.currency-popup .popup-header text {
  font-size: 32rpx;
  font-weight: bold;
  color: #333;
}

.currency-popup .popup-header .close-button {
  width: 60rpx;
  height: 60rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.currency-popup .search-box {
  display: flex;
  align-items: center;
  background-color: #f5f5f5;
  border-radius: 12rpx;
  padding: 0 20rpx;
  margin-bottom: 20rpx;
}

.currency-popup .search-box .search-input {
  flex: 1;
  height: 80rpx;
  font-size: 28rpx;
  margin-left: 10rpx;
  background: transparent;
  border: none;
  outline: none;
}

.currency-popup .currency-list-scroll {
  flex: 1;
  overflow-y: auto;
  max-height: calc(70vh - 120rpx - 80rpx - 40rpx);
}

.currency-popup .currency-list-scroll .currency-list-item {
  display: flex;
  align-items: center;
  padding: 20rpx 0;
  border-bottom: 1rpx solid #f5f5f5;
}

.currency-popup .currency-list-scroll .currency-list-item:active {
  background-color: #f9f9f9;
}

.currency-popup .currency-list-scroll .currency-list-item .currency-flag {
  font-size: 32rpx;
  margin-right: 16rpx;
}

.currency-popup .currency-list-scroll .currency-list-item .currency-info {
  flex: 1;
}

.currency-popup .currency-list-scroll .currency-list-item .currency-info .currency-name {
  font-size: 28rpx;
  color: #333;
  display: block;
}

.currency-popup .currency-list-scroll .currency-list-item .currency-info .currency-code {
  font-size: 24rpx;
  color: #999;
}
</style>



